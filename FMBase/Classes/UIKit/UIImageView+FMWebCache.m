//
//  UIImageView+FMWebCache.m
//  Pods
//
//

#import "UIImageView+FMWebCache.h"
#import <SDWebImage/SDWebImage.h>

@implementation UIImageView (FMWebCache)

- (void)fm_setRoundImageWithURL:(NSString *)imageURL
                    placeholder:(nullable UIImage *)placeholder{
    [self fm_setImageWithURL:imageURL placeholder:placeholder imageSize:self.bounds.size cornerRadius:self.bounds.size.width*0.5];
}

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder{
    [self fm_setImageWithURL:imageURL placeholder:placeholder imageSize:self.bounds.size cornerRadius:0];
}

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder
                 imageSize:(CGSize)imageSize{
    [self fm_setImageWithURL:imageURL placeholder:placeholder imageSize:imageSize cornerRadius:0];
}

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder
                 imageSize:(CGSize)imageSize
              cornerRadius:(CGFloat)cornerRadius{
    if (!([imageURL isKindOfClass:[NSString class]] && imageURL.length > 0)) {
        self.image = placeholder;
        return;
    }

    if (cornerRadius > 0 && !CGSizeEqualToSize(CGSizeZero, imageSize)) {
        SDImageResizingTransformer *resizingTransformer = [SDImageResizingTransformer transformerWithSize:imageSize scaleMode:SDImageScaleModeAspectFill];
        SDImageRoundCornerTransformer *cornerTransformer = [SDImageRoundCornerTransformer transformerWithRadius:cornerRadius corners:UIRectCornerAllCorners borderWidth:0 borderColor:[UIColor clearColor]];
        SDImagePipelineTransformer *transformer = [SDImagePipelineTransformer transformerWithTransformers:@[resizingTransformer, cornerTransformer]];
        [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholder options:0 context:@{SDWebImageContextImageTransformer: transformer}];
    }
    else{
        [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholder options:0 context:nil];
    }
    
}

@end
