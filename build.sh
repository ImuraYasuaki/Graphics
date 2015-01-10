#!/bin/bash

echo "BUILD_DIR: ${BUILD_DIR}"
echo "CONFIGURATION: ${CONFIGURATION}"

FRAMEWORK_POOL_DIR="${SRCROOT}/../Framework"
FRAMEWORK_DIR="${FRAMEWORK_POOL_DIR}/${PRODUCT_NAME}.framework"
FRAMEWORK_HEADERS_DIR="${FRAMEWORK_DIR}/Headers"
echo "Framework directory: ${FRAMEWORK_DIR}"

OUTPUT_HEADERS_DIR="${BUILT_PRODUCTS_DIR}${PUBLIC_HEADERS_FOLDER_PATH}"
echo "Output headers directory: ${OUTPUT_HEADERS_DIR}"

function CreateFrameworkDir() {
  if [ -e ${FRAMEWORK_POOL_DIR} ] ; then
   echo "exists framework pool directory: ${FRAMEWORK_POOL_DIR}"
  else
    mkdir ${FRAMEWORK_POOL_DIR}
  fi
  if [ -e ${FRAMEWORK_DIR} ] ; then
    echo "... Framework directory is exists.\nRecreate ... "

    rm -rf ${FRAMEWORK_DIR}
  fi
  echo "... Create Framework directory."
  mkdir ${FRAMEWORK_DIR}
  mkdir ${FRAMEWORK_HEADERS_DIR}
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

  $(build_command) -sdk ${TARGET_SDK}
  echo "TARGET_SDK: ${TARGET_SDK}"
}

# フレームワークディレクトリを作成
CreateFrameworkDir

LIBS=$(find "${BUILD_DIR}" -name '*.a')
echo ${LIBS}

LIB=${LIBS[0]}
echo "Lib file's path: ${LIB}"

INFOPLIST_FILE=$(find "${BUILT_PRODUCTS_DIR}" -name "Info.plist")
echo ${INFOPLIST_FILE}

cp ${LIB} "${FRAMEWORK_DIR}/"
cp "${OUTPUT_HEADERS_DIR}/"* "${FRAMEWORK_HEADERS_DIR}/"
cp ${INFOPLIST_FILE} "${FRAMEWORK_DIR}/"

#ビルドを実行
#for (sdks) {
#  Build ${SDK}
#}


