package com.speedEngine.speedBones.manager
{
   import com.adobe.utils.AGALMiniAssembler;
   import com.speedEngine.speedBones.display.DisplayObject;
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.display.Stage;
   import com.speedEngine.speedBones.model.AnimationData;
   import com.speedEngine.speedBones.model.ContainerData;
   import com.speedEngine.speedBones.model.DisplayData;
   import com.speedEngine.speedBones.model.ImageData;
   import com.speedEngine.speedBones.model.ParticleData;
   import com.speedEngine.speedBones.model.QuadData;
   import com.speedEngine.speedBones.model.RenderContainerData;
   import com.speedEngine.speedBones.model.TextFileldData;
   import com.speedEngine.speedBones.textures.AtfData;
   import com.speedEngine.speedBones.textures.SpeedTexture;
   import com.speedEngine.speedBones.textures.TextureData;
   import com.speedEngine.speedBones.utils.AGALPrograms;
   import com.speedEngine.speedBones.utils.NumberUtils;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   use namespace speedBones_internal;
   
   public class RenderManager
   {
      
      private static const RENDER_BUFFER_LEN:int = 524256;
      
      public static var drawTriangleNums:uint = 0;
      
      private static var _instance:RenderManager;
      
      public var renderTimes:Number;
      
      private var _isInitComplete:Boolean = false;
      
      private var _stage:flash.display.Stage;
      
      private var _stage3D:com.speedEngine.speedBones.display.Stage;
      
      private var _agalPrograms:AGALPrograms;
      
      private var _pipeSize:uint = 0;
      
      private var _skeletons:uint;
      
      private var _renderTextureMax:int = 1024;
      
      private var _stageColors:Array;
      
      private var _isTrace:Boolean = false;
      
      private var _renderIndexBuffer:IndexBuffer3D;
      
      private var _renderVertexBuffer:VertexBuffer3D;
      
      private var _renderTexture:Texture;
      
      private var _renderProgram:Program3D;
      
      private var _uvOutput:VertexBuffer3D;
      
      private var _xyOutput:VertexBuffer3D;
      
      private var _uvOutputContainer:VertexBuffer3D;
      
      private var _xyOutputContainer:VertexBuffer3D;
      
      private var _renderSrcTexture:Texture;
      
      private var _vertextXYBuffer:VertexBuffer3D;
      
      private var _vertextUVBuffer:VertexBuffer3D;
      
      private var _indexBuffer:IndexBuffer3D;
      
      private var _context3d:Context3D;
      
      private var _vertexXYBytesBatch:ByteArray = new ByteArray();
      
      private var _vertexUVBytesBatch:ByteArray = new ByteArray();
      
      private var _indexBytesBatch:ByteArray = new ByteArray();
      
      private var _controlStreamBytes:ByteArray = new ByteArray();
      
      private var _controlstreamController:Vector.<uint> = new Vector.<uint>();
      
      private var _controlstreamControllerIndex:Vector.<uint> = new Vector.<uint>();
      
      private var _indexOffset:uint = 0;
      
      private var _textures:Vector.<SpeedTexture> = new Vector.<SpeedTexture>();
      
      private var _shalderIndex:uint = 0;
      
      private var _programColorMultiplyAndOffset:Array = [];
      
      private var _programColorMultiply:Array = [];
      
      private var _programColorOffset:Array = [];
      
      private var _programNoneFilter:Array = [];
      
      private var _programBlurFilter:Array = [];
      
      private var _blendModeFunction:Vector.<Function> = new Vector.<Function>();
      
      private var _renderFunction:Vector.<Function> = new Vector.<Function>();
      
      private var _particleFunc:Vector.<Function> = new Vector.<Function>();
      
      private var _renderVector:Vector.<Number> = new Vector.<Number>();
      
      private var _renderFilterScenceScaleX:Number = 0;
      
      private var _renderFilterScenceScaleY:Number = 0;
      
      private var _renderFilterOffsetX:Number = 0;
      
      private var _renderFilterOffsetY:Number = 0;
      
      private var _renderFilterPosition:Number = 0;
      
      private var _renderContainerFilterPosition:Number = 0;
      
      private var _renderTextureIndex:uint = 0;
      
      private var _renderFormatIndex:uint = 0;
      
      private var _startTime:int;
      
      private var _curFrame:Number = 0;
      
      private var _lastFrame:Number = 0;
      
      private var _advanceFrame:Number = 0;
      
      private var _renderTime:uint = 0;
      
      private var _stageXYArray:Array;
      
      private var _renderData:Object = {};
      
      private var _imageData:Object;
      
      private var _imageDestTexture:Texture;
      
      private var _imageSrcTexture:Texture;
      
      private var _imageVector:VertexBuffer3D;
      
      private var _filterTexture:Vector.<Texture> = new Vector.<Texture>();
      
      private var _touchInstance:TouchManager;
      
      public function RenderManager()
      {
         super();
      }
      
      public static function get instance() : RenderManager
      {
         if(_instance == null)
         {
            _instance = new RenderManager();
         }
         return _instance;
      }
      
      public function initContext3d(param1:Context3D, param2:flash.display.Stage, param3:int = 1024) : void
      {
         if(_isInitComplete)
         {
            return;
         }
         _isInitComplete = true;
         _stage = param2;
         _stageXYArray = [];
         _context3d = param1;
         _renderTextureMax = param3;
         _stageColors = NumberUtils.getARGB(_stage.color);
         _context3d.configureBackBuffer(_stage.stageWidth,_stage.stageHeight,0,false);
         _stage3D = com.speedEngine.speedBones.display.Stage.current;
         _stage3D.reSize(_stage.stageWidth,_stage.stageHeight);
         _vertexXYBytesBatch.endian = "littleEndian";
         _vertexUVBytesBatch.endian = "littleEndian";
         _indexBytesBatch.endian = "littleEndian";
         _controlStreamBytes.endian = "littleEndian";
         initRenderTexture();
         initVertex3DBuffer();
         initRenderFunction();
         initBlendModeFunction();
         initProgram3D();
         _touchInstance = TouchManager.instance;
         _touchInstance.step(_stage);
         startFrameUpdate();
      }
      
      public function initVertex3DBuffer() : void
      {
         var _loc2_:* = 0;
         if(_vertextXYBuffer)
         {
            _vertextXYBuffer.dispose();
         }
         if(_vertextUVBuffer)
         {
            _vertextUVBuffer.dispose();
         }
         if(_indexBuffer)
         {
            _indexBuffer.dispose();
         }
         var _loc1_:Vector.<uint> = Vector.<uint>([0,3,1,1,2,3]);
         _vertextXYBuffer = _context3d.createVertexBuffer(65532,2);
         _vertextUVBuffer = _context3d.createVertexBuffer(65532,2);
         _indexBuffer = _context3d.createIndexBuffer(98298);
         _indexBytesBatch.length = 0;
         _indexBytesBatch.endian = "littleEndian";
         _loc2_ = 0;
         while(_loc2_ < 16383)
         {
            _indexBytesBatch.writeShort(_loc1_[0] + 4 * _loc2_);
            _indexBytesBatch.writeShort(_loc1_[1] + 4 * _loc2_);
            _indexBytesBatch.writeShort(_loc1_[2] + 4 * _loc2_);
            _indexBytesBatch.writeShort(_loc1_[3] + 4 * _loc2_);
            _indexBytesBatch.writeShort(_loc1_[4] + 4 * _loc2_);
            _indexBytesBatch.writeShort(_loc1_[5] + 4 * _loc2_);
            _loc2_++;
         }
         _indexBuffer.uploadFromByteArray(_indexBytesBatch,0,0,98298);
         _indexBytesBatch.length = 0;
         _context3d.setVertexBufferAt(0,_vertextXYBuffer,0,"float2");
         _context3d.setVertexBufferAt(1,_vertextUVBuffer,0,"float2");
      }
      
      private function initRenderTexture() : void
      {
         if(_renderProgram)
         {
            _renderProgram.dispose();
         }
         var _loc7_:String = "mov vt0, va0 \nadd vt0, vt0, vc0 \nmov op, vt0  \nmov v0, va1  \n";
         var _loc4_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc4_.assemble("vertex",_loc7_);
         var _loc9_:String = "tex ft0, v0, fs0 <2d,repeat,linear,nomip> \nmov oc,ft0";
         var _loc3_:AGALMiniAssembler = new AGALMiniAssembler();
         _loc3_.assemble("fragment",_loc9_);
         _renderProgram = this._context3d.createProgram();
         _renderProgram.upload(_loc4_.agalcode,_loc3_.agalcode);
         if(_renderIndexBuffer)
         {
            _renderIndexBuffer.dispose();
         }
         if(_renderVertexBuffer)
         {
            _renderVertexBuffer.dispose();
         }
         if(_uvOutput)
         {
            _uvOutput.dispose();
         }
         if(_xyOutput)
         {
            _uvOutput.dispose();
         }
         if(_uvOutputContainer)
         {
            _uvOutputContainer.dispose();
         }
         if(_xyOutputContainer)
         {
            _xyOutputContainer.dispose();
         }
         var _loc2_:Vector.<uint> = Vector.<uint>([0,1,3,1,2,3]);
         _renderIndexBuffer = this._context3d.createIndexBuffer(_loc2_.length);
         _renderIndexBuffer.uploadFromVector(_loc2_,0,_loc2_.length);
         var _loc8_:Vector.<Number> = new <Number>[-1,1,0,0,1,1,1,0,1,-1,1,1,-1,-1,0,1];
         _renderVertexBuffer = this._context3d.createVertexBuffer(_loc8_.length / 4,4);
         _renderVertexBuffer.uploadFromVector(_loc8_,0,_loc8_.length / 4);
         _loc8_ = Vector.<Number>([0,0,1,0,1,1,0,1]);
         _uvOutput = _context3d.createVertexBuffer(_loc8_.length / 2,2);
         _uvOutput.uploadFromVector(_loc8_,0,_loc8_.length / 2);
         _loc8_ = new <Number>[-1,1,1,1,1,-1,-1,-1];
         _xyOutput = _context3d.createVertexBuffer(_loc8_.length / 2,2);
         _xyOutput.uploadFromVector(_loc8_,0,_loc8_.length / 2);
         _uvOutputContainer = _context3d.createVertexBuffer(_loc8_.length / 2,2);
         _xyOutputContainer = _context3d.createVertexBuffer(_loc8_.length / 2,2);
         var _loc1_:int = 32;
         do
         {
            pushData(_loc1_,_loc1_,_renderData);
            _loc1_ *= 2;
         }
         while(_loc1_ <= _renderTextureMax);
         var _loc6_:Number = RenderContainerData.stageWidth;
         var _loc5_:Number = RenderContainerData.stageHeight;
         pushData(_loc6_,_loc5_,_renderData);
         _renderSrcTexture = _renderData[_loc6_ + "*" + _loc5_]["srcTexture"];
      }
      
      public function pushData(param1:int, param2:int, param3:Object) : void
      {
         var _loc6_:VertexBuffer3D = null;
         var _loc10_:Texture = null;
         var _loc8_:Texture = null;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc9_:Object = param3[param1 + "*" + param2];
         var _loc7_:Vector.<Number> = null;
         _loc5_ = param1 / _stage.stageWidth;
         _loc4_ = param2 / _stage.stageHeight;
         _loc7_ = Vector.<Number>([-_loc5_,_loc4_,_loc5_,_loc4_,_loc5_,-_loc4_,-_loc5_,-_loc4_]);
         _loc6_ = _context3d.createVertexBuffer(_loc7_.length / 2,2);
         _loc6_.uploadFromVector(_loc7_,0,_loc7_.length / 2);
         if(_loc9_ != null)
         {
            _loc9_["vertexXY"].dispose();
            _loc9_["vertexXY"] = _loc6_;
         }
         else
         {
            _loc10_ = _context3d.createTexture(param1,param2,"bgra",true);
            _loc8_ = _context3d.createTexture(param1,param2,"bgra",true);
            param3[param1 + "*" + param2] = {
               "destTexture":_loc8_,
               "srcTexture":_loc10_,
               "vertexXY":_loc6_
            };
         }
      }
      
      private function initBlendModeFunction() : void
      {
         _blendModeFunction.length = 0;
         _blendModeFunction[0] = blendModeNONE;
         _blendModeFunction[1] = blendModeNORMAL;
         _blendModeFunction[2] = blendModeADD;
         _blendModeFunction[3] = blendModeMULTIPLY;
         _blendModeFunction[4] = blendModeSCREEN;
         _blendModeFunction[5] = blendModeERASE;
      }
      
      private function blendModeNONE() : void
      {
         _context3d.setBlendFactors("one","zero");
      }
      
      private function blendModeNORMAL() : void
      {
         _context3d.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
      }
      
      private function blendModeADD() : void
      {
         _context3d.setBlendFactors("sourceAlpha","one");
      }
      
      private function blendModeMULTIPLY() : void
      {
         _context3d.setBlendFactors("destinationColor","oneMinusSourceAlpha");
      }
      
      private function blendModeSCREEN() : void
      {
         _context3d.setBlendFactors("sourceAlpha","one");
      }
      
      private function blendModeERASE() : void
      {
         _context3d.setBlendFactors("zero","oneMinusSourceAlpha");
      }
      
      public function get skeletons() : uint
      {
         return _skeletons;
      }
      
      public function get stage() : flash.display.Stage
      {
         if(_stage)
         {
            return _stage;
         }
         return null;
      }
      
      public function get isTrace() : Boolean
      {
         return _isTrace;
      }
      
      public function set isTrace(param1:Boolean) : void
      {
         _isTrace = param1;
      }
      
      private function initProgram3D() : void
      {
         disposePrograms(_programColorMultiplyAndOffset);
         disposePrograms(_programColorMultiply);
         disposePrograms(_programColorOffset);
         disposePrograms(_programNoneFilter);
         disposePrograms(_programBlurFilter);
         _agalPrograms = new AGALPrograms(_context3d,_programColorMultiplyAndOffset,_programColorMultiply,_programColorOffset,_programNoneFilter,_programBlurFilter);
      }
      
      private function disposePrograms(param1:Array) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] is Array)
            {
               for each(var _loc2_:Object in param1[_loc3_])
               {
                  _loc2_.dispose();
               }
            }
            else if(param1[_loc3_].hasOwnProperty("dispose"))
            {
               param1[_loc3_]["dispose"]();
            }
            _loc3_++;
         }
         param1.length = 0;
      }
      
      private function initRenderFunction() : void
      {
         _renderFunction.length = 0;
         _renderFunction[0] = GlobeScaleOffset;
         _renderFunction[1] = GlobeScaleOffset1ColorFilter;
         _renderFunction[2] = GlobeScaleOffset2ColorFilter;
         _renderFunction[3] = GlobeScaleOffset3ColorFilter;
         _renderFunction[4] = GlobleSkewOffset;
         _renderFunction[5] = GlobleSkewOffset1ColorFilter;
         _renderFunction[6] = GlobleSkewOffset2ColorFilter;
         _renderFunction[7] = GlobleSkewOffset3ColorFilter;
         _renderFunction[8] = ColorMultiplyAndOffset;
         _renderFunction[9] = ColorMultiply;
         _renderFunction[10] = ColorOffset;
         _renderFunction[11] = NoneFilter;
         _renderFunction[12] = GlobeScaleOffsetBlurFilter;
         _renderFunction[13] = GlobeScaleOffsetStrokeFilter;
         _renderFunction[14] = innerBlurFilter;
         _renderFunction[15] = innerGlowFilter;
         _renderFunction[16] = GlobeScaleOffsetGlowFilter;
         _renderFunction[17] = argbScaleOffset;
         _renderFunction[18] = renderParticle;
         _renderFunction[19] = renderContainerFilter;
         _renderFunction[20] = renderContainerFilterComplete;
      }
      
      private function GlobleSkewOffset() : void
      {
         _shalderIndex = 4;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function argbScaleOffset() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgram(_programNoneFilter[8]);
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setTextureAt(0,null);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_controlStreamBytes.readUnsignedInt());
         drawTriangleNums = drawTriangleNums + 1;
         _indexOffset += _controlStreamBytes.readUnsignedInt();
      }
      
      private function GlobleSkewOffset1ColorFilter() : void
      {
         _shalderIndex = 5;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,5,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 80;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobleSkewOffset2ColorFilter() : void
      {
         _shalderIndex = 6;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,10,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 160;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobleSkewOffset3ColorFilter() : void
      {
         _shalderIndex = 7;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,15,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 240;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobeScaleOffset() : void
      {
         _shalderIndex = 0;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobeScaleOffset1ColorFilter() : void
      {
         _shalderIndex = 1;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,5,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 80;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobeScaleOffset2ColorFilter() : void
      {
         _shalderIndex = 2;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,10,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 160;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function GlobeScaleOffset3ColorFilter() : void
      {
         _shalderIndex = 3;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("fragment",0,15,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 240;
         _renderFunction[_controlStreamBytes.readUnsignedInt()]();
      }
      
      private function ColorMultiplyAndOffset() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgramConstantsFromByteArray("fragment",16,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgram(_programColorMultiplyAndOffset[_shalderIndex][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function ColorMultiply() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgramConstantsFromByteArray("fragment",16,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgram(_programColorMultiply[_shalderIndex][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function ColorOffset() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgramConstantsFromByteArray("fragment",16,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgram(_programColorOffset[_shalderIndex][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function NoneFilter() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgram(_programNoneFilter[_shalderIndex][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function innerBlurFilter() : void
      {
         var _loc9_:uint = _shalderIndex;
         _shalderIndex = 0;
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         var _loc10_:Number = _controlStreamBytes.readFloat();
         var _loc8_:Number = _controlStreamBytes.readFloat();
         var _loc1_:Number = _controlStreamBytes.readFloat();
         var _loc7_:Number = _controlStreamBytes.readFloat();
         var _loc4_:Number = _controlStreamBytes.readFloat();
         var _loc6_:Number = _controlStreamBytes.readFloat();
         var _loc3_:Number = _controlStreamBytes.position + 16;
         var _loc11_:int = _loc10_ < _loc8_ ? _loc8_ : _loc10_;
         _loc11_ = int(NumberUtils.getNextPowerOfTwo(_loc11_));
         _loc11_ = _loc11_ < 32 ? 32 : _loc11_;
         _loc4_ = (_loc4_ + _loc10_ / 2) * 2;
         _loc6_ = (_loc6_ + _loc8_ / 2) * 2;
         _controlStreamBytes.position = _renderFilterPosition;
         _renderFilterScenceScaleX = _controlStreamBytes.readFloat();
         _renderFilterScenceScaleY = _controlStreamBytes.readFloat();
         _renderFilterOffsetX = _controlStreamBytes.readFloat();
         _renderFilterOffsetY = _controlStreamBytes.readFloat();
         _renderFilterScenceScaleX = _renderFilterScenceScaleX * _stage.stageWidth / _loc11_;
         _renderFilterScenceScaleY = _renderFilterScenceScaleY * _stage.stageHeight / _loc11_;
         _controlStreamBytes.position = _loc3_;
         _renderVector.length = 0;
         _renderVector.push(_renderFilterScenceScaleX,_renderFilterScenceScaleY,-_loc4_ / _loc11_,_loc6_ / _loc11_);
         _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
         var _loc5_:Number = _renderFilterOffsetX + _loc4_ / _stage.stageWidth;
         var _loc2_:Number = _renderFilterOffsetY - _loc6_ / _stage.stageHeight;
         renderFilter(_loc1_,_loc7_,_loc10_,_loc8_,false,_loc5_,_loc2_,_loc11_,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
         _shalderIndex = _loc9_;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _context3d.setProgramConstantsFromByteArray("vertex",0,1,_controlStreamBytes,_renderFilterPosition);
      }
      
      private function innerGlowFilter() : void
      {
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 24;
         _context3d.setProgramConstantsFromByteArray("fragment",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         var _loc1_:int = int(_controlStreamBytes.readUnsignedInt());
         _context3d.setProgram(_programBlurFilter[1][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_loc1_);
         drawTriangleNums = drawTriangleNums + 1;
         _context3d.setProgram(_programNoneFilter[0][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_loc1_);
         drawTriangleNums = drawTriangleNums + 1;
         _indexOffset += _controlStreamBytes.readUnsignedInt();
      }
      
      private function GlobeScaleOffsetBlurFilter() : void
      {
         _shalderIndex = 1;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterScenceScaleX = _controlStreamBytes.readFloat();
         _renderFilterScenceScaleY = _controlStreamBytes.readFloat();
         _renderFilterOffsetX = _controlStreamBytes.readFloat();
         _renderFilterOffsetY = _controlStreamBytes.readFloat();
         _context3d.setProgramConstantsFromByteArray("vertex",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         var _loc8_:int = _controlStreamBytes.readFloat();
         var _loc7_:int = _controlStreamBytes.readFloat();
         var _loc1_:int = _controlStreamBytes.readFloat();
         var _loc6_:int = _controlStreamBytes.readFloat();
         var _loc3_:Number = _controlStreamBytes.readFloat();
         var _loc5_:Number = _controlStreamBytes.readFloat();
         var _loc9_:int = _loc8_ < _loc7_ ? _loc7_ : _loc8_;
         _loc9_ = int(NumberUtils.getNextPowerOfTwo(_loc9_));
         _loc9_ = _loc9_ < 32 ? 32 : _loc9_;
         _loc3_ = (_loc3_ + _loc8_ / 2) * 2;
         _loc5_ = (_loc5_ + _loc7_ / 2) * 2;
         _renderFilterScenceScaleX = _renderFilterScenceScaleX * _stage.stageWidth / _loc9_;
         _renderFilterScenceScaleY = _renderFilterScenceScaleY * _stage.stageHeight / _loc9_;
         _renderVector.length = 0;
         _renderVector.push(_renderFilterScenceScaleX,_renderFilterScenceScaleY,-_loc3_ / _loc9_,_loc5_ / _loc9_);
         _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
         _context3d.setProgramConstantsFromByteArray("fragment",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 4;
         var _loc4_:Number = _renderFilterOffsetX + _loc3_ / _stage.stageWidth;
         var _loc2_:Number = _renderFilterOffsetY - _loc5_ / _stage.stageHeight;
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         renderFilter(_loc1_,_loc6_,_loc8_,_loc7_,false,_loc4_,_loc2_,_loc9_,_controlStreamBytes.readUnsignedInt());
         _indexOffset += _controlStreamBytes.readUnsignedInt();
      }
      
      private function GlobeScaleOffsetStrokeFilter() : void
      {
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _context3d.setProgramConstantsFromByteArray("vertex",0,2,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 32;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 24;
         _context3d.setProgramConstantsFromByteArray("fragment",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 4;
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         var _loc1_:int = int(_controlStreamBytes.readUnsignedInt());
         _context3d.setProgram(_programBlurFilter[1][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_loc1_);
         drawTriangleNums = drawTriangleNums + 1;
         _context3d.setProgram(_programNoneFilter[0][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_loc1_);
         drawTriangleNums = drawTriangleNums + 1;
         _indexOffset += _controlStreamBytes.readUnsignedInt();
      }
      
      private function GlobeScaleOffsetGlowFilter() : void
      {
         _shalderIndex = 1;
         _renderTextureIndex = _controlStreamBytes.readUnsignedInt();
         _renderFormatIndex = _textures[_renderTextureIndex].formatIndex;
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _renderFilterPosition = _controlStreamBytes.position;
         _renderFilterScenceScaleX = _controlStreamBytes.readFloat();
         _renderFilterScenceScaleY = _controlStreamBytes.readFloat();
         _renderFilterOffsetX = _controlStreamBytes.readFloat();
         _renderFilterOffsetY = _controlStreamBytes.readFloat();
         _context3d.setProgramConstantsFromByteArray("vertex",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",20,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 4;
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         var _loc10_:Number = _controlStreamBytes.readFloat();
         var _loc9_:Number = _controlStreamBytes.readFloat();
         var _loc3_:Number = _controlStreamBytes.readFloat();
         var _loc8_:Number = _controlStreamBytes.readFloat();
         var _loc5_:Number = _controlStreamBytes.readFloat();
         var _loc7_:Number = _controlStreamBytes.readFloat();
         var _loc11_:int = _loc10_ < _loc9_ ? _loc9_ : _loc10_;
         _loc11_ = int(NumberUtils.getNextPowerOfTwo(_loc11_));
         _loc11_ = _loc11_ < 32 ? 32 : _loc11_;
         _loc5_ = (_loc5_ + _loc10_ / 2) * 2;
         _loc7_ = (_loc7_ + _loc9_ / 2) * 2;
         _renderFilterScenceScaleX = _renderFilterScenceScaleX * _stage.stageWidth / _loc11_;
         _renderFilterScenceScaleY = _renderFilterScenceScaleY * _stage.stageHeight / _loc11_;
         var _loc1_:Number = _renderFilterScenceScaleX / DisplayData.SCENCE_SCALEX;
         _renderVector.length = 0;
         _renderVector.push(_renderFilterScenceScaleX,_renderFilterScenceScaleY,-_loc5_ / _loc11_,_loc7_ / _loc11_);
         _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
         _context3d.setProgramConstantsFromByteArray("fragment",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 4;
         var _loc6_:Number = _renderFilterOffsetX + _loc5_ / _stage.stageWidth;
         var _loc4_:Number = _renderFilterOffsetY - _loc7_ / _stage.stageHeight;
         _blendModeFunction[_controlStreamBytes.readUnsignedInt()]();
         var _loc2_:uint = _controlStreamBytes.readUnsignedInt();
         renderFilter(_loc3_,_loc8_,_loc10_,_loc9_,true,_loc6_,_loc4_,_loc11_,_loc2_);
         _context3d.setProgramConstantsFromByteArray("vertex",0,1,_controlStreamBytes,_renderFilterPosition);
         _context3d.setTextureAt(0,_textures[_renderTextureIndex].texture);
         _context3d.setProgram(_programNoneFilter[0][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,_loc2_);
         drawTriangleNums = drawTriangleNums + 1;
         _indexOffset += _controlStreamBytes.readUnsignedInt();
      }
      
      private function renderFilter(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Number = 0, param7:Number = 0, param8:* = 0, param9:uint = 0) : void
      {
         var _loc12_:Texture = null;
         var _loc11_:Texture = null;
         _imageData = _renderData[param8 + "*" + param8];
         _imageDestTexture = _imageData["destTexture"];
         _imageSrcTexture = _imageData["srcTexture"];
         _imageVector = _imageData["vertexXY"];
         var _loc10_:int = param1 + param2;
         var _loc13_:int = 0;
         if(_loc10_ > 1)
         {
            _loc11_ = _imageDestTexture;
            _context3d.setRenderToTexture(_loc11_);
            _context3d.clear(0,0,0,0);
            _context3d.setProgram(_programNoneFilter[0][_renderFormatIndex]);
            _context3d.drawTriangles(_indexBuffer,_indexOffset,param9);
            drawTriangleNums = drawTriangleNums + 1;
            _filterTexture[0] = _imageSrcTexture;
            _filterTexture[1] = _imageDestTexture;
            _context3d.setProgram(_programBlurFilter[2]);
            _context3d.setBlendFactors("one","oneMinusSourceAlpha");
            _context3d.setVertexBufferAt(0,_xyOutput,0,"float2");
            _context3d.setVertexBufferAt(1,_uvOutput,0,"float2");
            while(_loc13_ < param1)
            {
               _loc11_ = getPassTexture(_loc13_);
               _context3d.setRenderToTexture(_loc11_);
               _context3d.clear(0,0,0,0);
               _loc12_ = getPassTexture(_loc13_ + 1);
               _context3d.setTextureAt(0,_loc12_);
               _context3d.drawTriangles(_renderIndexBuffer);
               drawTriangleNums = drawTriangleNums + 1;
               _loc13_++;
            }
            while(_loc13_ < _loc10_)
            {
               _loc11_ = getPassTexture(_loc13_);
               _context3d.setRenderToTexture(_loc11_);
               _context3d.clear(0,0,0,0);
               _loc12_ = getPassTexture(_loc13_ + 1);
               _context3d.setTextureAt(0,_loc12_);
               if(param5 && _loc13_ + 1 == _loc10_)
               {
                  _context3d.setProgram(_programBlurFilter[3]);
               }
               _context3d.drawTriangles(_renderIndexBuffer);
               drawTriangleNums = drawTriangleNums + 1;
               _loc13_++;
            }
            _context3d.setRenderToBackBuffer();
            _context3d.setVertexBufferAt(0,_imageVector,0,"float2");
            _context3d.setTextureAt(0,_loc11_);
            _renderVector.length = 0;
            _renderVector.push(param6,param7,0,0);
            _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
            _context3d.setProgram(_renderProgram);
            _context3d.drawTriangles(_renderIndexBuffer);
            drawTriangleNums = drawTriangleNums + 1;
            _context3d.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
            _context3d.setVertexBufferAt(0,_vertextXYBuffer,0,"float2");
            _context3d.setVertexBufferAt(1,_vertextUVBuffer,0,"float2");
            return;
         }
         _context3d.setProgram(_programBlurFilter[_shalderIndex][_renderFormatIndex]);
         _context3d.drawTriangles(_indexBuffer,_indexOffset,param9);
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function renderContainerFilter() : void
      {
         _controlStreamBytes.position += 16;
         _renderContainerFilterPosition = _controlStreamBytes.position;
         _controlStreamBytes.position += 76;
         _context3d.setRenderToTexture(_renderSrcTexture);
         _context3d.clear(0,0,0,0);
      }
      
      private function renderContainerFilterComplete() : void
      {
         var _loc6_:Rectangle = new Rectangle();
         _loc6_.x = _controlStreamBytes.readFloat();
         _loc6_.y = _controlStreamBytes.readFloat();
         _loc6_.width = _controlStreamBytes.readFloat();
         _loc6_.height = _controlStreamBytes.readFloat();
         var _loc5_:uint = _controlStreamBytes.position;
         _controlStreamBytes.position = _renderContainerFilterPosition;
         _controlStreamBytes.position += 36;
         _controlStreamBytes.position += 8;
         var _loc1_:int = _controlStreamBytes.readFloat();
         var _loc2_:int = _controlStreamBytes.readFloat();
         var _loc7_:int = _loc6_.width < _loc6_.height ? _loc6_.height : _loc6_.width;
         _loc7_ = int(NumberUtils.getNextPowerOfTwo(_loc7_));
         _loc7_ = _loc7_ < 32 ? 32 : _loc7_;
         var _loc4_:Number = _loc7_ / 2;
         _imageData = _renderData[_loc7_ + "*" + _loc7_];
         _imageDestTexture = _imageData["destTexture"];
         _imageSrcTexture = _imageData["srcTexture"];
         _imageVector = _imageData["vertexXY"];
         _filterTexture[0] = _imageSrcTexture;
         _filterTexture[1] = _imageDestTexture;
         renderRevert(_loc4_,_loc6_,_imageDestTexture);
         _controlStreamBytes.position = _renderContainerFilterPosition;
         var _loc3_:uint = _controlStreamBytes.readUnsignedInt();
         _context3d.setProgramConstantsFromByteArray("vertex",4,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _context3d.setProgramConstantsFromByteArray("fragment",0,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         _controlStreamBytes.position += 24;
         _context3d.setProgramConstantsFromByteArray("fragment",1,1,_controlStreamBytes,_controlStreamBytes.position);
         _controlStreamBytes.position += 16;
         renderCFilter(_loc1_,_loc2_,_loc6_,_loc3_ != 12,_loc4_);
         _controlStreamBytes.position = _loc5_;
      }
      
      private function renderRevert(param1:Number, param2:Rectangle, param3:Texture, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param5)
         {
            _loc7_ = param2.x;
            _loc8_ = param2.y;
            _loc9_ = param2.width;
            _loc6_ = param2.height;
            _renderVector.length = 0;
            _renderVector.push(-1,1,(_loc9_ - param1) / param1,1,(_loc9_ - param1) / param1,-(_loc6_ - param1) / param1,-1,-(_loc6_ - param1) / param1);
            _xyOutputContainer.uploadFromVector(_renderVector,0,_renderVector.length / 2);
            _loc11_ = RenderContainerData.stageWidth;
            _loc10_ = RenderContainerData.stageHeight;
            _renderVector.length = 0;
            _renderVector.push(_loc7_ / _loc11_,_loc8_ / _loc10_,(_loc7_ + _loc9_) / _loc11_,_loc8_ / _loc10_,(_loc7_ + _loc9_) / _loc11_,(_loc8_ + _loc6_) / _loc10_,_loc7_ / _loc11_,(_loc8_ + _loc6_) / _loc10_);
            _uvOutputContainer.uploadFromVector(_renderVector,0,_renderVector.length / 2);
         }
         _renderVector.length = 0;
         _renderVector.push(0,0,0,0);
         _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
         _context3d.setVertexBufferAt(0,_xyOutputContainer,0,"float2");
         _context3d.setVertexBufferAt(1,_uvOutputContainer,0,"float2");
         _context3d.setRenderToTexture(param3);
         if(param4)
         {
            _context3d.clear(0,0,0,0);
         }
         _context3d.setTextureAt(0,_renderSrcTexture);
         _context3d.setProgram(_renderProgram);
         _context3d.drawTriangles(_renderIndexBuffer);
         drawTriangleNums = drawTriangleNums + 1;
      }
      
      private function renderCFilter(param1:int, param2:int, param3:Rectangle, param4:Boolean = false, param5:Number = 0) : void
      {
         var _loc9_:Texture = null;
         var _loc10_:int = 0;
         var _loc8_:int = param1 + param2;
         _context3d.setVertexBufferAt(0,_xyOutput,0,"float2");
         _context3d.setVertexBufferAt(1,_uvOutput,0,"float2");
         _context3d.setProgram(_programBlurFilter[2]);
         _context3d.setBlendFactors("one","oneMinusSourceAlpha");
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc9_ = getPassTexture(_loc10_);
            _context3d.setRenderToTexture(_loc9_);
            _context3d.clear(0,0,0,0);
            _context3d.setTextureAt(0,getPassTexture(_loc10_ + 1));
            if(param4 && _loc10_ == _loc8_ - 1)
            {
               _context3d.setProgram(_programBlurFilter[3]);
            }
            _context3d.drawTriangles(_renderIndexBuffer);
            drawTriangleNums = drawTriangleNums + 1;
            _loc10_++;
         }
         if(param4)
         {
            renderRevert(param5,param3,_loc9_,false,false);
            _context3d.setVertexBufferAt(0,_xyOutput,0,"float2");
            _context3d.setVertexBufferAt(1,_uvOutput,0,"float2");
         }
         _context3d.setRenderToBackBuffer();
         _context3d.setVertexBufferAt(0,_imageVector,0,"float2");
         _context3d.setTextureAt(0,_loc9_);
         var _loc6_:Number = (param3.x - (DisplayData.HALF_WIDTH - param5)) * DisplayData.SCENCE_SCALEX;
         var _loc7_:Number = -(param3.y - (DisplayData.HALF_HEIGHT - param5)) * DisplayData.SCENCE_SCALEY;
         _renderVector.length = 0;
         _renderVector.push(_loc6_,_loc7_,0,0);
         _context3d.setProgramConstantsFromVector("vertex",0,_renderVector);
         _context3d.setProgram(_renderProgram);
         _context3d.drawTriangles(_renderIndexBuffer);
         _context3d.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
         drawTriangleNums = drawTriangleNums + 1;
         _context3d.setVertexBufferAt(0,_vertextXYBuffer,0,"float2");
         _context3d.setVertexBufferAt(1,_vertextUVBuffer,0,"float2");
      }
      
      private function renderParticle() : void
      {
         _particleFunc[_controlStreamBytes.readUnsignedInt()]();
         _context3d.setVertexBufferAt(0,_vertextXYBuffer,0,"float2");
         _context3d.setVertexBufferAt(1,_vertextUVBuffer,0,"float2");
      }
      
      public function pushParticle(param1:Function) : uint
      {
         var _loc2_:int = _particleFunc.indexOf(param1);
         if(_loc2_ > -1)
         {
            return _loc2_;
         }
         _particleFunc.push(param1);
         return _particleFunc.length - 1;
      }
      
      public function removeParticle(param1:Function) : void
      {
         var _loc2_:int = _particleFunc.indexOf(param1);
         if(_loc2_ > -1)
         {
            _particleFunc[_loc2_] = null;
         }
      }
      
      public function removeParticleByIndex(param1:int) : void
      {
         if(param1 > -1 && param1 < _particleFunc.length)
         {
            _particleFunc[param1] = null;
         }
      }
      
      private function getPassTexture(param1:int) : Texture
      {
         return _filterTexture[param1 % 2];
      }
      
      public function createBitmapData(param1:BitmapData) : uint
      {
         var _loc3_:TextureData = new TextureData();
         _loc3_.data = param1;
         var _loc2_:SpeedTexture = new SpeedTexture(_context3d,_loc3_);
         _textures.push(_loc2_);
         return _textures.length - 1;
      }
      
      public function updateTexture(param1:int) : void
      {
         _textures[param1].updateTexture();
      }
      
      public function createTexture(param1:ByteArray, param2:String) : uint
      {
         var _loc4_:AtfData = new AtfData(param1,0,param2);
         var _loc3_:SpeedTexture = new SpeedTexture(_context3d,_loc4_);
         _textures.push(_loc3_);
         return _textures.length - 1;
      }
      
      speedBones_internal function createImageData#12(param1:AtfData) : ImageData
      {
         var _loc3_:SpeedTexture = new SpeedTexture(_context3d,param1);
         _textures.push(_loc3_);
         var _loc2_:ImageData = createImageData#1();
         _loc2_.setTexture(_loc3_,_textures.length - 1);
         return _loc2_;
      }
      
      speedBones_internal function getAllSpeedTexture(param1:Object) : uint
      {
         var _loc3_:uint = 0;
         for each(var _loc2_:SpeedTexture in _textures)
         {
            if(_loc2_.data is AtfData)
            {
               if(_loc2_.data.path)
               {
                  param1[_loc2_.data.path] = _loc2_;
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      speedBones_internal function getParticleData() : ParticleData
      {
         return new ParticleData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      speedBones_internal function createQuadData() : QuadData
      {
         return new QuadData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      speedBones_internal function createContainerData() : ContainerData
      {
         return new ContainerData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      speedBones_internal function createTextFieldData() : TextFileldData
      {
         return new TextFileldData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      speedBones_internal function createImageDataFromBitmapData(param1:BitmapData) : ImageData
      {
         var _loc4_:TextureData = new TextureData();
         _loc4_.data = param1;
         var _loc3_:SpeedTexture = new SpeedTexture(_context3d,_loc4_);
         _textures.push(_loc3_);
         var _loc2_:ImageData = createImageData#1();
         _loc2_.setTexture(_loc3_,_textures.length - 1);
         return _loc2_;
      }
      
      public function createAnimationData() : AnimationData
      {
         return new AnimationData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      private function createImageData#1() : ImageData
      {
         return new ImageData(_vertexXYBytesBatch,_vertexUVBytesBatch,_controlStreamBytes,_controlstreamController,_controlstreamControllerIndex);
      }
      
      public function getSpeedTexture(param1:int) : SpeedTexture
      {
         return _textures[param1];
      }
      
      public function clearTextures() : void
      {
         var _loc2_:SpeedTexture = null;
         var _loc3_:int = 0;
         var _loc1_:int = TextFieldManager.instance.textureIndex;
         _loc2_ = _textures[_loc1_];
         _loc3_ = 0;
         while(_loc3_ < _textures.length)
         {
            if(_loc3_ != _loc1_)
            {
               _textures[_loc3_].dispose();
            }
            _loc3_++;
         }
         _textures.length = 0;
         _textures.push(_loc2_);
         TextFieldManager.instance.updateTextureIndex(_textures.length - 1);
      }
      
      public function disposeTexture(param1:uint) : void
      {
         if(param1 < _textures.length)
         {
            _textures[param1].dispose();
         }
      }
      
      public function startFrameUpdate() : void
      {
         _stage.addEventListener("resize",onResizeHandle);
         _stage.addEventListener("enterFrame",onUpdateFrame);
         _startTime = getTimer();
      }
      
      public function stopFrameUpdate() : void
      {
         _stage.removeEventListener("resize",onResizeHandle);
         _stage.removeEventListener("enterFrame",onUpdateFrame);
      }
      
      protected function onResizeHandle(param1:Event) : void
      {
         _stage.addEventListener("enterFrame",__onResize,false,10,true);
      }
      
      protected function __onResize(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_stage.stageWidth != _stage3D.stageWidth || _stage.stageHeight != _stage3D.stageHeight)
         {
            if(_context3d.driverInfo == "Disposed")
            {
               return;
            }
            _context3d.configureBackBuffer(_stage.stageWidth,_stage.stageHeight,0,false);
            _stage3D.reSize(_stage.stageWidth,_stage.stageHeight);
            _loc2_ = 32;
            do
            {
               pushData(_loc2_,_loc2_,_renderData);
               _loc2_ *= 2;
            }
            while(_loc2_ <= _renderTextureMax);
            pushData(RenderContainerData.stageWidth,RenderContainerData.stageHeight,_renderData);
         }
         else
         {
            _stage.removeEventListener("enterFrame",__onResize);
         }
      }
      
      public function onUpdateFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(_stage3D.numChildren == 0)
         {
            _startTime = getTimer();
            return;
         }
         if(_isTrace)
         {
            _loc2_ = getTimer();
         }
         if(_context3d.driverInfo == "Disposed")
         {
            return;
         }
         _context3d.clear(_stageColors[1],_stageColors[2],_stageColors[3],1);
         _context3d.setBlendFactors("sourceAlpha","oneMinusSourceAlpha");
         _context3d.setVertexBufferAt(0,_vertextXYBuffer,0,"float2");
         _context3d.setVertexBufferAt(1,_vertextUVBuffer,0,"float2");
         _vertexXYBytesBatch.length = 0;
         _vertexUVBytesBatch.length = 0;
         _controlStreamBytes.length = 0;
         _controlstreamController.length = 0;
         _controlstreamController.push(0);
         _controlstreamController.push(0);
         _controlstreamController.push(0);
         _controlstreamController.push(0);
         _controlstreamControllerIndex.length = 0;
         _controlstreamControllerIndex.push(0);
         _controlstreamControllerIndex.push(1);
         _controlstreamControllerIndex.push(2);
         _controlstreamControllerIndex.push(3);
         _touchInstance.removeAll();
         _curFrame = (getTimer() - _startTime) / 40;
         _advanceFrame = _curFrame - _lastFrame;
         _lastFrame = _curFrame;
         ergodicAndDraw(_stage3D,1,0,0,1,1,0,0,_stage3D.passSpeed,_stage3D.touchable,_stage3D.visible);
         _pipeSize = _controlstreamController.length >> 2;
         _vertexUVBytesBatch.length = 524256 * _pipeSize;
         _vertexXYBytesBatch.length = 524256 * _pipeSize;
         _controlStreamBytes.position = 0;
         drawTriangleNums = 0;
         _skeletons = _vertexXYBytesBatch.position >> 5;
         _loc3_ = 0;
         while(_loc3_ < _pipeSize)
         {
            _indexOffset = 0;
            _vertextXYBuffer.uploadFromByteArray(_vertexXYBytesBatch,_controlstreamController[_loc3_ << 2],0,65532);
            _vertextUVBuffer.uploadFromByteArray(_vertexUVBytesBatch,_controlstreamController[_loc3_ << 2],0,65532);
            _controlStreamBytes.position = _controlstreamController[(_loc3_ << 2) + 1];
            _renderTime = _controlstreamController[(_loc3_ << 2) + 2];
            _loc4_ = 0;
            while(_loc4_ < _renderTime)
            {
               _renderFunction[_controlStreamBytes.readUnsignedInt()]();
               _loc4_++;
            }
            _loc3_++;
         }
         _context3d.present();
         _touchInstance.onEnter();
         if(_isTrace)
         {
            renderTimes = getTimer() - _loc2_;
         }
      }
      
      private function ergodicAndDraw(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Boolean, param11:Boolean) : void
      {
         var _loc15_:DisplayObject = null;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc18_:Vector.<DisplayObject> = param1.children;
         var _loc12_:int = int(_loc18_.length);
         var _loc14_:int = -1;
         while(++_loc14_ < _loc12_)
         {
            _loc15_ = _loc18_[_loc14_];
            if(_loc15_.isDispose)
            {
               trace("调用ergodicAndDraw方法{invalid_utf8=227}{invalid_utf8=128}?" + _loc15_.name + "】对象已经被dispose但没有移除stage,请检查代码！{invalid_utf8=239}{invalid_utf8=188}?",_loc15_);
            }
            else
            {
               _loc15_.repaint(param2,param3,param4,param5,param6,param7,param8,_stageXYArray);
               _loc17_ = _loc15_.visible && param11;
               _loc13_ = _advanceFrame * param9 * _loc15_.passSpeed;
               if(_loc17_ == true)
               {
                  _loc15_.render(_loc13_);
                  _loc16_ = _loc15_.touchable && param10;
                  if(_loc16_ == true)
                  {
                     _touchInstance.addTouch(_loc15_);
                  }
               }
               _loc15_.advanceFrame(_loc13_);
               if(_loc15_ is DisplayObjectContainer)
               {
                  ergodicAndDraw(_loc15_ as DisplayObjectContainer,param2 * _loc15_.alpha,_stageXYArray[0],_stageXYArray[1],param5 * _loc15_.scaleX,param6 * _loc15_.scaleY,(param7 + _loc15_.skewX) % 360,(param8 + _loc15_.skewY) % 360,_loc15_.passSpeed * param9,_loc16_,_loc17_);
                  (_loc15_ as DisplayObjectContainer).renderAfter();
               }
            }
         }
      }
      
      public function requestContext3DAgain(param1:Context3D) : void
      {
         _context3d = param1;
         _context3d.configureBackBuffer(_stage.stageWidth,_stage.stageHeight,0,false);
         initRenderTexture();
         initVertex3DBuffer();
         initProgram3D();
         upLoadTextureAgain();
      }
      
      private function upLoadTextureAgain() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(_textures.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _textures[_loc2_].uploadTextureAgain(_context3d);
            _loc2_++;
         }
      }
   }
}

