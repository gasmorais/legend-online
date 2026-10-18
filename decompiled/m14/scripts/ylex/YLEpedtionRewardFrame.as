package ylex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.YLExpedtionManger;
   import mvc.module.children.ChildData;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import ylex.view.YLExpedetionRewardView;
   
   public class YLEpedtionRewardFrame extends Frame
   {
      
      private var _view:YLExpedetionRewardView;
      
      private var _kbg:Scale9CornerImage;
      
      private var _data:ChildCampInfo;
      
      public function YLEpedtionRewardFrame()
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
         var _loc2_:ChildCampTempTempInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc7_:ChildData = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         _data = param1;
         if(_view && _data)
         {
            _loc2_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
            _loc4_ = int(_loc2_.getSneakCountByDiff(_data.difficulty));
            if(_data.difficulty == 2)
            {
               _loc3_ = int(ConfigInfoManager.instance.getChildCampSneakCount2());
            }
            else if(_data.difficulty == 3)
            {
               _loc3_ = int(ConfigInfoManager.instance.getChildCampSneakCount3());
            }
            if(_loc2_)
            {
               showRewards(_view._rwHbox1,_loc2_.StationedAward);
               if(_data.difficulty > 1 && _loc3_ <= _data.defenseCount)
               {
                  _loc5_ = _loc2_.getSneakFinshiAward(_data.difficulty);
                  showRewards(_view._rwHbox2,_loc5_);
               }
            }
            _view._rwPoint.text = "" + YLExpedtionManger.instance.model.doubleExpPoint;
            _loc7_ = ChildManager.instance.model.getChildById(_data.childId);
            _loc6_ = (_loc4_ - _data.defenseCount) * ylModel.sneakAttackLossPrecent;
            _loc8_ = _loc7_.growthGrade * 1200 * (100 - _loc6_) / 100;
            _view._rwExp.text = "" + _loc8_;
         }
      }
      
      private function showRewards(param1:HBox, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc8_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc9_:Array = param2.split("|");
         var _loc5_:int = int(_loc9_ ? _loc9_.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc9_[_loc6_];
            _loc8_ = _loc4_.split(",");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            param1.addChild(_loc3_);
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc8_[0]);
            _loc7_.count = int(_loc8_[1]);
            _loc3_.data = _loc7_;
            _loc6_++;
         }
      }
      
      private function get ylModel() : YLExpedtionModel
      {
         return YLExpedtionManger.instance.model;
      }
      
      private function initView() : void
      {
         _kbg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLEpedtionRewardFrame.bg");
         _view = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.view5");
         addToContent(_kbg);
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view._rwSigleBtn.addEventListener("click",sigleRewardHandler);
         _view._rwDoubleBtn.addEventListener("click",doubleRewardHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view._rwSigleBtn.removeEventListener("click",sigleRewardHandler);
         _view._rwDoubleBtn.removeEventListener("click",doubleRewardHandler);
      }
      
      private function sigleRewardHandler(param1:MouseEvent) : void
      {
         YLExpedtionManger.instance.sendOp(6,_data.id);
         dispose();
      }
      
      private function doubleRewardHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = int(YLExpedtionManger.instance.model.doubleExpPoint);
         var _loc2_:String = LanguageMgr.GetTranslation("YLExpeditionItem.buyExp",_loc5_);
         SimpleAlertHelper.instance.data = [doubleGet,_loc5_];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc4_,true,true);
      }
      
      private function doubleGet(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param3)
            {
               YLExpedtionManger.instance.sendOp(6,_data.id,2);
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
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
         _data = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("YLEpedtionRewardFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

