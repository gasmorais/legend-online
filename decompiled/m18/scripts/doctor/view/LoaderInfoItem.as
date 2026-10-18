package doctor.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class LoaderInfoItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:Image;
      
      private var _loaderName:FilterFrameText;
      
      private var _loaderProgress:FilterFrameText;
      
      private var _loaderSpeed:FilterFrameText;
      
      private var _resule:FilterFrameText;
      
      private var _path:String;
      
      private var _name:String;
      
      private var _startTime:Number = 0;
      
      private var _completeBack:Function;
      
      private var _loader:URLLoader;
      
      private var _request:URLRequest;
      
      public function LoaderInfoItem(param1:String, param2:String)
      {
         super();
         _path = param2;
         _name = param1;
         _loader = new URLLoader();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,507,29);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("doctor.LoaderItemBack");
         _loaderName = ComponentFactory.Instance.creatComponentByStylename("doctor.LoaderItemName");
         _loaderProgress = ComponentFactory.Instance.creatComponentByStylename("doctor.LoaderItemProgress");
         _loaderSpeed = ComponentFactory.Instance.creatComponentByStylename("doctor.LoaderItemSpeed");
         _resule = ComponentFactory.Instance.creatComponentByStylename("doctor.LoaderItemResule");
         addChild(_back);
         addChild(_loaderName);
         addChild(_loaderProgress);
         addChild(_loaderSpeed);
         addChild(_resule);
         _loaderName.text = _name;
         _loaderProgress.text = "Progresso: Aguardando...";
      }
      
      private function initEvent() : void
      {
         _loader.addEventListener("complete",__onDataLoadComplete);
         _loader.addEventListener("progress",__onProgress);
         _loader.addEventListener("httpStatus",__onStatus);
         _loader.addEventListener("ioError",__onIOError);
      }
      
      private function removeEvent() : void
      {
         _loader.removeEventListener("complete",__onDataLoadComplete);
         _loader.removeEventListener("progress",__onProgress);
         _loader.removeEventListener("httpStatus",__onStatus);
         _loader.removeEventListener("ioError",__onIOError);
      }
      
      public function start(param1:Function) : void
      {
         _completeBack = param1;
         _startTime = getTimer();
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["ran"] = Math.random();
         _loader.dataFormat = "binary";
         _request = new URLRequest(_path);
         _request.method = "GET";
         _request.data = _loc2_;
         _loader.load(_request);
      }
      
      public function stop() : void
      {
         removeEvent();
         try
         {
            _loader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      private function __onStatus(param1:HTTPStatusEvent) : void
      {
      }
      
      private function __onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function __onDataLoadComplete(param1:Event) : void
      {
         removeEvent();
         _loaderProgress.text = "Progresso: 100%";
         var _loc2_:Number = _loader.bytesTotal * 1000 / ((getTimer() - _startTime) * 1024);
         if(_loc2_ > 1000)
         {
            _loaderSpeed.text = (_loc2_ / 1024).toFixed(2) + "MB/s";
         }
         else
         {
            _loaderSpeed.text = _loc2_.toFixed(2) + "KB/s";
         }
         _resule.text = "Verificando arquivo...";
         try
         {
            _loader.close();
         }
         catch(err:Error)
         {
         }
         if(_loader.data.length == 0)
         {
            _completeBack("Arquivo" + _path + "Extensão é zero");
            _completeBack = null;
            return;
         }
         check(_loader.data as ByteArray);
      }
      
      private function __onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:String = (param1.bytesLoaded / param1.bytesTotal * 100).toFixed(2);
         _loaderProgress.text = "Progresso：" + _loc2_ + "%";
         _resule.text = "Carregando arquivo...";
      }
      
      private function check(param1:ByteArray) : void
      {
         var _loc2_:String = ComponentSetting.getUrlMd5(_path);
         if(ComponentSetting.checkNeedAnalyzeMd5(_loc2_))
         {
            if(ComponentSetting.compareMD5(param1,_loc2_))
            {
               _completeBack("Arquivo" + _path + "Sucedido");
               _resule.text = "Verificação do arquivo sucedido";
            }
            else
            {
               _completeBack("Arquivo" + _path + "Falha");
               _resule.text = "Falha na verificação do arquivo";
            }
         }
         else
         {
            _completeBack("Arquivo" + _path + "Falha");
            _resule.text = "Falha na verificação do arquivo";
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_loaderName);
         ObjectUtils.disposeObject(_loaderProgress);
         ObjectUtils.disposeObject(_loaderSpeed);
         ObjectUtils.disposeObject(_resule);
         _back = null;
         _loaderName = null;
         _loaderProgress = null;
         _loaderSpeed = null;
         _resule = null;
         _path = null;
      }
   }
}

