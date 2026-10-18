package ylex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YLExpedtionManger;
   import mvc.module.ylex.ChildCampInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   import ylex.view.YLXepedtionFightInfoView;
   
   public class YLExpedtionFightInfoFrame extends Frame
   {
      
      public var _view4:YLXepedtionFightInfoView;
      
      private var _kbg:Scale9CornerImage;
      
      private var _data:ChildCampInfo;
      
      public function YLExpedtionFightInfoFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _view4.data = _data;
         }
      }
      
      private function initView() : void
      {
         _kbg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLExpedtionFightInfoFrame.bg");
         _view4 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.view4");
         addToContent(_kbg);
         addToContent(_view4);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view4._dkActiveBtn.addEventListener("click",activeProHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view4._dkActiveBtn.removeEventListener("click",activeProHandler);
      }
      
      private function activeProHandler(param1:MouseEvent) : void
      {
         var _loc3_:ChildCampTempTempInfo = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
         var _loc7_:int = int(_loc3_.getSneakCountByDiff(_data.difficulty));
         if(_data.sneakCount >= _loc7_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("YLExpeditionItem.fightFull"));
            return;
         }
         var _loc11_:Array = YLExpedtionManger.instance.model.buyCoverPoint;
         var _loc8_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
         var _loc12_:Number = _data.startTime + _loc3_.StationedTime * 1000;
         var _loc5_:int = Math.ceil((_loc12_ - _loc8_) / 1000 / 60);
         if(_loc5_ <= 0)
         {
            return;
         }
         var _loc6_:int = Math.ceil(_loc5_ / int(_loc11_[0]));
         var _loc4_:int = _loc6_ * int(_loc11_[1]);
         var _loc9_:String = LanguageMgr.GetTranslation("YLExpeditionItem.buyCover",_loc4_);
         SimpleAlertHelper.instance.data = [buyCover,_loc4_];
         var _loc10_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc13_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc13_,_loc9_,_loc10_,_loc2_,true,true);
      }
      
      private function buyCover(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param3)
            {
               YLExpedtionManger.instance.sendOp(3,_data.id);
               dispose();
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         ObjectUtils.disposeObject(_view4);
         _view4 = null;
         super.dispose();
         _data = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("YLExpedtionFightInfoFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

