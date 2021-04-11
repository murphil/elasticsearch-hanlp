FROM debian:buster-slim as downloader
ARG hanlp_data_version=1.7.5
WORKDIR /tmp
RUN apt update -yqq && apt install unar curl -yqq \
    # can't support < 1.7.5, the release file not host by github.
    && curl -sSL https://github.com/hankcs/HanLP/releases/download/v${hanlp_data_version}/data-for-${hanlp_data_version}.zip -o hanlp-data.zip \
    && unar -q hanlp-data.zip \
    && rm hanlp-data.zip

# https://github.com/hankcs/HanLP
# https://github.com/medcl/elasticsearch-analysis-pinyin
# https://github.com/KennFalcon/elasticsearch-analysis-hanlp
# https://github.com/medcl/elasticsearch-analysis-ik

FROM elasticsearch:7.5.1
ARG plugin_version=7.5.1
RUN set eux \
  ; elasticsearch-plugin install --batch \
    https://github.com/KennFalcon/elasticsearch-analysis-hanlp/releases/download/v${plugin_version}/elasticsearch-analysis-hanlp-${plugin_version}.zip \
  ; elasticsearch-plugin install --batch \
    https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v${plugin_version}/elasticsearch-analysis-pinyin-${plugin_version}.zip \
  ; elasticsearch-plugin install --batch \
    https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${plugin_version}/elasticsearch-analysis-ik-${plugin_version}.zip \
  ; chown -R 1000 plugins

COPY --from=downloader --chown=1000:1000 ["/tmp/hanlp-data/data/model","plugins/analysis-hanlp/data/model"]
