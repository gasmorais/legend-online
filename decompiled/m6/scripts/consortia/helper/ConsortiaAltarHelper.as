package consortia.helper
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import flash.display.Sprite;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaAltarHelper
   {
      
      private static var _alert:BaseAlerFrame;
      
      private static var _callback:Function;
      
      public function ConsortiaAltarHelper()
      {
         super();
      }
      
      public static function canBless(param1:ConsortiaModel, param2:int, param3:int, param4:int, param5:Function, param6:int = 0) : Boolean
      {
         var _loc7_:String = null;
         if(param1.alTarBlessLeftTime >= param2)
         {
            _loc7_ = LanguageMgr.GetTranslation("consortia.helper.ConsortiaAltarHelper.command01");
            MessageTipManager.instance().show(_loc7_);
            return false;
         }
         if(param6 > param1.reputation)
         {
            _loc7_ = LanguageMgr.GetTranslation("ConsortiaAltarHelper.reputation.text");
            MessageTipManager.instance().show(_loc7_);
            return false;
         }
         if(param3 > param4)
         {
            addOffer();
            return false;
         }
         if(param1.lastaltarGoods)
         {
            param5();
         }
         return true;
      }
      
      private static function addOffer() : void
      {
         SimpleAlertHelper.instance.data = [__addOfferCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("consortia.helper.ConsortiaAltarHelper.content02");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      private static function __addOfferCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.consortiaController.closeBuildingFrame(false);
            FrameControllerManager.instance.consortiaController.showContributeFrame();
         }
      }
      
      private static function __resposeHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2)
         {
            param1.stopImmediatePropagation();
            return;
         }
         _alert.removeEventListener("response",__resposeHandler);
         _alert.dispose();
         _alert = null;
         _callback(param1);
         _callback = null;
      }
      
      public static function getGoodsInfo(param1:ConsortiaModel) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.count = param1.blessInfo.count;
         _loc2_.templateId = param1.blessInfo.templateId;
         return _loc2_;
      }
      
      public static function randomArraySort(param1:Array, param2:int = 10) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc7_:Array = getPosList(param2);
         var _loc5_:int = Math.min(param1.length,param2);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = Math.floor(Math.random() * _loc7_.length);
            _loc3_.push(_loc7_[_loc4_]);
            _loc7_.splice(_loc4_,1);
            _loc6_++;
         }
         return _loc3_;
      }
      
      private static function getPosList(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_.push(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function tweenItem(param1:Sprite, param2:Frame, param3:Function) : void
      {
         var _loc4_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc4_ = param2.globalToLocal(_loc4_);
         param1.x = _loc4_.x;
         param1.y = _loc4_.y;
         param2.addToContent(param1);
         TweenLite.to(param1,0.5,{
            "x":144,
            "y":132,
            "scaleX":1.8,
            "scaleY":1.8,
            "onComplete":param3
         });
      }
   }
}

