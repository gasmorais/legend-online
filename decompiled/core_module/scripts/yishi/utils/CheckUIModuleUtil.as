package yishi.utils
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import yishi.view.community.LoadingSceneView;
   
   public class CheckUIModuleUtil
   {
      
      private static var _instance:CheckUIModuleUtil;
      
      private var _funcDic:SimpleDictionary = new SimpleDictionary();
      
      private var _dataDic:SimpleDictionary = new SimpleDictionary();
      
      public function CheckUIModuleUtil()
      {
         super();
      }
      
      public static function get instance() : CheckUIModuleUtil
      {
         if(!_instance)
         {
            _instance = new CheckUIModuleUtil();
         }
         return _instance;
      }
      
      public function tryCall(param1:String, param2:Function, param3:Array = null) : void
      {
         _funcDic.add(param1,param2);
         _dataDic.add(param1,param3);
         var _loc4_:String = ComponentSetting.getUISourcePath(param1);
         if(!LoaderManagerII.instance.isLoaded(_loc4_))
         {
            LoadingSceneView.instance.show();
         }
         LoaderManagerII.instance.load(_loc4_,3,0,onUIMoudleComplete,progressHandler,null,param1);
      }
      
      private function onUIMoudleComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_funcDic[param1.args])
         {
            LoadingSceneView.instance.hide();
            if(_dataDic[param1.args])
            {
               _funcDic[param1.args](_dataDic[param1.args]);
            }
            else
            {
               _funcDic[param1.args]();
            }
            _funcDic.del(param1.args);
            _dataDic.del(param1.args);
         }
      }
      
      private function progressHandler(param1:LoaderInfo) : void
      {
         var _loc3_:Number = param1.bytesLoaded / param1.bytesTotal;
         var _loc2_:String = ComponentSetting.getMD5FileNameByFilePath(param1.url);
         LoadingSceneView.instance.update(_loc3_ * 100);
      }
   }
}

