package yishi.resolve
{
   import org.serialize.XmlCoder;
   import yishi.manager.TempleteSaveManager;
   
   public class TemplateBaseResolve
   {
      
      protected var _list:XMLList;
      
      protected var _coder:XmlCoder;
      
      protected var _obj:Object;
      
      protected var _templateXml:XML;
      
      protected var _index:int;
      
      protected var _callback:Function;
      
      protected var _dic:Object;
      
      public var isComplete:Boolean = false;
      
      public var totalLength:int = 0;
      
      protected var _cacheName:String = null;
      
      public function TemplateBaseResolve(param1:XMLList, param2:Function)
      {
         super();
         _callback = param2;
         _list = param1;
         totalLength = _list.length();
         _coder = new XmlCoder();
         _obj = {};
      }
      
      public function clear() : void
      {
         _list = null;
         _coder = null;
         _obj = null;
         _templateXml = null;
      }
      
      protected function checkFirst() : void
      {
      }
      
      public function resolveImp() : void
      {
         _index = _index + 1;
         if(_index >= totalLength)
         {
            if(_cacheName)
            {
               TempleteSaveManager.instance.save(_dic,_cacheName);
            }
            isComplete = true;
            _list = null;
            handlerCallBack();
         }
      }
      
      public function imediatyly() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < totalLength)
         {
            resolveImp();
            _loc1_++;
         }
      }
      
      protected function handlerCallBack() : void
      {
         if(_callback != null)
         {
            _callback(_dic);
            _callback = null;
         }
      }
      
      public function checkCache() : void
      {
         var _loc1_:Object = null;
         preCache();
         if(_cacheName)
         {
            _loc1_ = TempleteSaveManager.instance.load(_cacheName);
            if(_loc1_ != null)
            {
               _dic = _loc1_;
               isComplete = true;
               _list = null;
               handlerCallBack();
               totalLength = 0;
            }
         }
      }
      
      protected function preCache() : void
      {
      }
   }
}

