# How to create responsive images for Drupal

Creating responsive images is a science mixed with an art. This guide will give you the steps you need to create these images, but remember that it is flexible.

Read the following article to learn more about how responsive images work before you begin creating them. https://cloudfour.com/thinks/responsive-images-101-part-5-sizes

## Define the image specs

### **Question 1**: Is this Image going to be relatively the same size on many screen sizes?

- **Relatively the same size**: (**_Retina Only_**) You really only need to set up images for normal and retina screens (2x). This does not need to have a "sizes" attribute on the image tag.
- **Scales significantly**: (**_Breakpoints_**) You will need to create breakpoints and various image sizes so that the device is not loading more data than it needs. This does need to have a "sizes" attribute on the image tag.

### **Question 2**: Will this image be just scaled or will it be scaled and cropped?

- **Scaled**: You will only need to know the width or the height, but not both. The second value will be derived from the first because the image will keep it's aspect ratio.
- **Scaled and Cropped**: If there is a set aspect ratio, then you will always need to know both the height and width value. What is that aspect ratio?

For example, if the image is always a square, then it has a 1:1 aspect ratio and will need to be scaled and cropped to get the correct image size.

### **Question 3**: What are the dimensions of you images?

To determine this you will need the information from the above questions. You need to collect different information based on the image type needed.

<details>
<summary>

#### Retina Only

</summary>

 Retina Only images have rather simple requirements. You are basically creating the image you need and an image double the size.

**_Needed Specs_**

```
- 1x: Dimension that you will see the image at most of the time. This can be with only or both height and width.
- 2x: Double the dimensions of the 1x
- Fallback: For retina images, the fallback is the 1x value
```

_Example Specs_

> - 1x: 300px Width
> - 2x: 600px Width
> - Fallback: 1x value

> - 1x: 300x200
> - 2x: 600x400
> - Fallback: 1x value

</details>

<details>
<summary>

#### Breakpoints

</summary>

 For images that have breakpoints we need a bit more information. We need to create a list of all the images that we will be creating as well as the sizes that these images break on.

**_Needed Specs_**

```
- Sizes attr: the list of media query and screen sizes the browser uses to deturming the image to use
- Crops: List of crops that will need to be created
```

First, use browser resizing to figure out the smallest image size. At that point, also capture the screen resolution and how much of the screen the image takes up in VW units. VW does not need to be exact, just generally good for the image size.

_Example_

> - Viewport width: 390
> - Image width: 344
> - vw units: 88

---

##### Console helper

You can use the browser's console to help you view the image sizes are you scale you image.

Select the image in the DOM that you are reviewing. Then, in the console, paste the following code.

```javascript
console.log({
	viewport: window.innerWidth,
	img_width: $0.getBoundingClientRect().width,
	vw: ($0.getBoundingClientRect().width)/window.innerWidth
});
```

---

Then slowly resize the browser up to figure out where the important breakpoints are that you will need to account for. There is no set number for the number of breakpoints you need to account for. This really depends on the image and the design. Capture the information from above for each breakpoint you need to support.

You also might want to consider looking into what viewport widths are most commonly used to make sure that those viewport widths are accounted for.

**Calculating the Crops**

- **Not cropped**: You only need the widths you already have. Double each of them to account for modern displays.
- **Cropped**: Figure out the aspect ratio (1:1 , 16:9, etc) and do the math to figure out what the height should be. You can use a tool like https://andrew.hedges.name/experiments/aspect_ratio to work this out or a spreadsheet. Then, double each of them to account for modern displays

_Example_

> * 672 x 378
> * 720 x 405
> * 832 x 468
> * 1072 x 603

> * 672
> * 720
> * 832
> * 1072

**Calculating Sizes**

The sizes is a sting of comma separated list of media queries and about how much of the screen the image should take up at that breakpoint. Example `(max-width: 599px) 87vw, (max-width: 767px) 89vw, (max-width: 965px) 44vw, 434px`

You do not choose what image the browser will use at each width, you just tell the browser about how much of the screen real-estate the image will be using at various widths. The browser will choose the best image based on that information.

Use your knowledge of how media queries work in css and the breakpoints that you have to create this list.

Remember to start with the smallest breakpoint first and work up to the largest, then last is the fallback if no media query fits.

_Example Specs_

> * Sizes attr: (max-width: 599px) 87vw, (max-width: 767px) 89vw, (max-width: 965px) 44vw, 434px
> * Crops: List of crops that will need to be created
>     * 672 x 378
>     * 720 x 405
>     * 832 x 468
>     * 1072 x 603


</details>



## Setup Responsive image

Setting up the responsive image in Drupal is slightly different depending on the type.

<details>
<summary>

### Retina Only

</summary>

#### Add to breakpoints.yml

In the THEMENAME.breakpoints.yml file add the following and update the machine name and label:

```yml
uswds_sec.name_of_style:
  label: Name of Style
  mediaQuery: ''
  weight: 0
  multipliers:
    - 1x
    - 2x
```

#### Add image styles (/admin/config/media/image-styles)

Create two image styles, 1x and 2x.Generally you will do the following, but this might not always be the case for you specific situation. Use your judgement.

* **Not cropped**: Use the Scale filter and only set the width
* **Cropped**: Use the scale and cropped and set both dimensions

#### Add Responsive Image style (/admin/config/media/responsive-image-style)

1. Create new responsive image style
   * For the breakpoint group choose you current theme
2. For each of the the breakpoints you created in the breakpoints.yml file,
   * Choose "<span dir="">Select a single image style</span>"
   * Choose the image style the corresponds to the breakpoint.
3. Set your fallback image style

</details>

<details>
<summary>

### Breakpoints

</summary>

#### Add image styles (/admin/config/media/image-styles)

Create an Image style for **each** of the crops that you have listed.

Generally you will do the following, but this might not always be the case for you specific situation. Use your judgement.

* **Not cropped**: Use the Scale filter and only set the width
* **Cropped**: Use the scale and cropped and set both dimensions

#### Add Responsive Image style (/admin/config/media/responsive-image-style)

1. Create new responsive image style
   * For the breakpoint group choose "Responsive Image"
   * Choose you fallback image and save
2. Open the single closed accordion
   * choose "<span dir="">Select multiple image styles and use the sizes attribute.</span>"
   * Fill in the "<span dir="">Sizes</span>" with the list of sizes you created
   * Choose all of the Image styles you made in the pervious step

</details>

## Setup Image Media Display mode  

1. Create a new "<span dir="">view mode</span>" for media (/admin/structure/display-modes/view)
2. Add the new "<span dir="">view mode</span>" to Images Media Type in the "Custom display settings" tab at the bottom of the page (/admin/structure/media/manage/image_media/display)
3. Open the new view Mode and update the fields displayed
4. Edit the "<span dir="">Format</span>" of the image field to be "Responsive Image" then open the formatter settings and choose the responsive image style you just created.

## Use the Image Media Display mode on an entity

1. Navigate to the entity type's (node, block, etc) "Manage Display" page
2. Find your entity reference field that it referencing the Media Image
3. Edit the "<span dir="">Format</span>" of the entity reference field to be "Rendered entity" then open the formatter settings and choose the View mode you just created.
