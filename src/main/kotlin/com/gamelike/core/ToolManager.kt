package com.gamelike.core

import com.gamelike.core.tool.GeneratorTool
import org.springframework.ai.tool.ToolCallbackProvider
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


/**
 * @author violet
 * @since 2025/4/6
 */
@Configuration
class ToolManager {
    @Bean
    fun tools() =
        ToolCallbackProvider.from(
            GeneratorTool
                .toolCallback()
        )
}