#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void makeText (sf::Font *font, sf::Text *text);

void patch (const char *filename);

void display (sf::RenderWindow *window, sf::Text *text, 
              sf::Sprite *sprite1, sf::Sprite *sprite2);

size_t TargetPointer = 79;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

int main ()
{
    sf::RenderWindow window(sf::VideoMode(1200, 675), "FSociety Patcher");
    window.setFramerateLimit(15);

    sf::Image image;
    assert(image.loadFromFile("image.jpeg"));

    sf::Texture texture;
    texture.loadFromImage(image);

    sf::Sprite sprite1;
    sprite1.setTexture(texture);   
    sprite1.setTextureRect(sf::IntRect(0, 0, 1200, 675));

    sf::Sprite sprite2;
    sprite2.setTexture(texture);
    sprite2.setTextureRect(sf::IntRect(0, 660, 1200, 675));

    sf::Font font;
    sf::Text text;
    makeText(&font, &text);

    sf::Music music;
    assert(music.openFromFile("music.ogg"));
    music.play();

    patch("../Vlados/MAIN.COM");

    display(&window, &text, &sprite1, &sprite2);

    return 0;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void makeText (sf::Font *font, sf::Text *text)
{
    (*font).loadFromFile("font.ttf");
    
    (*text).setFont(*font);
    (*text).setString("Patching...");
    (*text).setCharacterSize(48);
    (*text).setPosition(950, 550);   

    return;
}

void patch (const char *filename)
{
    FILE *input = fopen(filename, "rb");
    assert(input);

    fseek(input, 0, SEEK_END);
    size_t symbolsCount = (size_t) ftell(input);
    rewind(input); 

    char *buffer = (char *) calloc (symbolsCount + 1, sizeof(*buffer));
    fread(buffer, symbolsCount, sizeof(*buffer), input);
    fclose(input);

    buffer[TargetPointer]     = 0xEB;
    buffer[TargetPointer + 1] = 0x0F;
    buffer[TargetPointer + 2] = 0x90;

    FILE *output = fopen("CRACK.COM", "wb");
    assert(output);

    fwrite(buffer, symbolsCount, sizeof(*buffer), output);
    fclose(output);

    free(buffer);

    return;
}

void display (sf::RenderWindow *window,  sf::Text *text, 
              sf::Sprite *sprite1, sf::Sprite *sprite2)
{
    sf::Clock  clock;
    sf::Sprite sprite;

    while ((*window).isOpen())
    {
        sf::Event event;
        while ((*window).pollEvent(event))
            if (event.type == sf::Event::Closed)
                (*window).close();

        (*window).clear();

        if (rand() < RAND_MAX / 10)
            sprite = *sprite2;

        else
            sprite = *sprite1;

        (*window).draw(sprite);

        if ((int) clock.getElapsedTime().asSeconds() % 2)
        {
            (*text).setFillColor(sf::Color::Red);
            (*window).draw(*text);
        }

        (*window).display();
    }

    return;
}
