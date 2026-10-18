package map.outercity.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.internals.interfaces.IOuterFrame;
   import map.outercity.view.frame.CityInfoFrame;
   import map.outercity.view.frame.FieldInfoFrame;
   import map.outercity.view.frame.TreasureInfoFrame;
   import yishi.utils.SimpleAlertHelper;
   
   public class OuterFrameManager
   {
      
      private static var instance:OuterFrameManager;
      
      private var frameMap:Dictionary;
      
      private var data:Object;
      
      public function OuterFrameManager()
      {
         super();
         if(instance != null)
         {
            throw new Error("instance is exsit");
         }
         init();
      }
      
      public static function getInstance() : OuterFrameManager
      {
         if(instance == null)
         {
            instance = new OuterFrameManager();
         }
         return instance;
      }
      
      public function init() : void
      {
         frameMap = new Dictionary();
         frameMap[1] = new CityInfoFrame();
         frameMap[2] = new FieldInfoFrame();
         frameMap[4] = new TreasureInfoFrame();
      }
      
      public function open(param1:uint, param2:Object = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:IOuterFrame = null;
         closeAll();
         data = param2;
         if(data.hasOwnProperty("tempInfo") && data.info.types != 20)
         {
            SimpleAlertHelper.instance.data = [onOuterCityAttack];
            _loc3_ = LanguageMgr.GetTranslation("map.outercity.view.bossinfo.attackMsg",data.tempInfo.MapPhysicsTempName);
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc3_,_loc4_,_loc5_,true,false,false);
         }
         else
         {
            _loc7_ = frameMap[param1];
            if(_loc7_ != null)
            {
               _loc7_.show(data);
            }
         }
         StageReferance.stage.dispatchEvent(new MouseEvent("mouseDown"));
      }
      
      private function onOuterCityAttack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SoundManager.instance.play("022");
            OuterCityManager.instance.controler.sendAttack(data.posX,data.posY);
         }
      }
      
      public function closeAll() : void
      {
         var _loc2_:IOuterFrame = null;
         for(var _loc1_:String in frameMap)
         {
            _loc2_ = frameMap[_loc1_];
            _loc2_.close();
         }
      }
      
      public function getFrameById(param1:uint) : IOuterFrame
      {
         return frameMap[param1];
      }
      
      public function dispose() : void
      {
         var _loc2_:IOuterFrame = null;
         closeAll();
         for(var _loc1_:String in frameMap)
         {
            _loc2_ = frameMap[_loc1_];
            _loc2_.dispose();
            delete frameMap[_loc1_];
         }
         instance = null;
      }
   }
}

