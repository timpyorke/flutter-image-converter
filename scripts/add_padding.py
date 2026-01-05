import os
from PIL import Image

def add_padding(input_path, output_path, scale_factor=0.7):
    """
    Adds padding to an image by scaling it down and centering it on a transparent background.
    """
    try:
        if not os.path.exists(input_path):
            print(f"Error: Input file not found at {input_path}")
            return

        img = Image.open(input_path).convert("RGBA")
        width, height = img.size
        
        # Calculate new size
        new_width = int(width * scale_factor)
        new_height = int(height * scale_factor)
        
        # Resize image
        resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
        
        # Create new canvas
        canvas = Image.new("RGBA", (width, height), (255, 255, 255, 0))
        
        # Calculate position to center
        x = (width - new_width) // 2
        y = (height - new_height) // 2
        
        # Paste resized image onto canvas
        canvas.paste(resized_img, (x, y), resized_img)
        
        # Save output
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        canvas.save(output_path)
        print(f"Successfully created padded icon at {output_path}")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # Define paths
    project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    input_icon = os.path.join(project_root, "assets", "images", "app_icon.png")
    output_icon = os.path.join(project_root, "assets", "images", "app_icon_padded.png")
    
    add_padding(input_icon, output_icon)
