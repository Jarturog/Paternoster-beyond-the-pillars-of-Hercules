/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package imagetopixel;

/**
 *
 * @author Marta
 */
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import javax.imageio.ImageIO;

public class ImageToPixel {

    private static String imagePath = "paternoster.bmp";
    private static String outputPath = "ImageToPixel.txt";

    public static void main(String[] args) {

        BufferedImage image = null;

        try {
            image = ImageIO.read(new File(imagePath));
            int width = image.getWidth();
            int height = image.getHeight();
            FileWriter fw = new FileWriter(outputPath);
            int count = 0;

            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    int pixel = image.getRGB(x, y);
                    int red = (pixel >> 16) & 0xff;
                    int green = (pixel >> 8) & 0xff;
                    int blue = pixel & 0xff;
                    String hexPixel = String.format("$%02X%02X%02X", blue, green, red);
                    if (count % 8 == 0) {
                        fw.write("DC.L ");
                    }
                    fw.write(hexPixel);
                    count++;
                    if (count % 8 == 0) {
                        fw.write("\n");
                    } else if (count % 8 != 0 && x != width - 1 && y != height - 1) {
                        fw.write(", ");
                    }
                }
            }
            fw.close();
            System.out.println("Pixels saved to " + outputPath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
