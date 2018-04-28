//
//  GiphyAPIEnums.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//



public enum GiphyAPIRating: String {
    case Y = "Y"
    case G = "G"
    case PG = "PG"
    case PG13 = "PG-13"
    case R = "R"
    
    static let allValues = [GiphyAPIRating.Y.rawValue, GiphyAPIRating.G.rawValue, GiphyAPIRating.PG.rawValue, GiphyAPIRating.PG13.rawValue, GiphyAPIRating.R.rawValue]
    
}

public enum GiphyAPIEndpoint: String {
    case Search = "search"
    case Trending = "trending"
}



public enum ImageVariant: String {
    case FixeHeightStill = "fixed_height_still"
    case OriginalStill = "original_still"
    case FixedWidth = "fixed_width"
    case FixedHeightSmallStill = "fixed_height_small_still"
    case FixedHeightDownsampled = "fixed_height_downsampled"
    case Preview = "preview"
    case FixedHeightSmall = "fixed_height_small"
    case DownsizedStill = "downsized_still"
    case Downsized = "downsized"
    case DownsizedLarge = "downsized_large"
    case FixedWidthSmallStill = "fixed_width_small_still"
    case PreviewWebp = "preview_webp"
    case FixedWidthStill = "fixed_width_still"
    case FixedWidthSmall = "fixed_width_small"
    case DownsizedSmall = "downsized_small"
    case FixedWidthDownsampled = "fixed_width_downsampled"
    case DownsizedMedium = "downsized_medium"
    case Looping = "looping"
    case OriginalMP4 = "original_mp4"
    case PreviewGif = "preview_gif"
    case Still480w = "480w_still"
    case FixedHeight = "fixed_height"
    case Original = "original"
}
