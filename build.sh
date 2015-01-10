#!/bin/bash

echo "BUILD_DIR: ${BUILD_DIR}"
echo "CONFIGURATION: ${CONFIGURATION}"

FRAMEWORK_DIR="${SRCROOT}/../${PRODUCT_NAME}.framework"
echo "Framework directory: ${FRAMEWORK_DIR}"

function CreateFrameworkDir() {
  if [ -e ${FRAMEWORK_DIR} ] ; then
    echo "... Framework directory is exists.\nRecreate ... "

    rm -rf ${FRAMEWORK_DIR}
  fi
  echo "... Create Framework directory."
  mkdir ${FRAMEWORK_DIR}
  mkdir "${FRAMEWORK_DIR}/Headers"
}

function Build() {
  TARGET_SDK=$1
  if [ ${TARGET_SDK} -eq "" ] ; then
    echo "... No Build Target."
    return
  fi

  build_command=xcodebuild build -target $(PROJECT_NAME) \
    -project $(PROJECT_NAME).xcodeproj \
    -configuration $(CONFIGURATION) \
    ONLY_ACTIVE_ARCH=NO \
    BUILD_DIR=$(BUILD_DIR) \
    BUILD_ROOT=$(BUILD_ROOT)

  $(build_command} -sdk ${TARGET_SDK}
  echo "TARGET_SDK: ${TARGET_SDK}"
}

# フレームワークディレクトリを作成
CreateFrameworkDir

LIBS=$(find "${BUILD_DIR}" -name '*.a')
echo ${LIBS}

#ビルドを実行
#for (sdks) {
#  Build ${SDK}
#}
#
