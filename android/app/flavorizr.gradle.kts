import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.codenour.image_converters.dev"
            resValue(type = "string", name = "app_name", value = "Image Converters Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.codenour.image_converters"
            resValue(type = "string", name = "app_name", value = "Image Converters")
        }
    }
}