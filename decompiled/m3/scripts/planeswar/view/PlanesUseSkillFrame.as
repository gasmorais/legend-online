package planeswar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.datas.templates.PlanesFuncTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesUseSkillFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var selectSkillText:FilterFrameText;
      
      private var energyBuyBtn:IconButton;
      
      private var pointBuyBtn:IconButton;
      
      private var upShowView:PlanesSkillShowView;
      
      private var downShowView:PlanesSkillShowView;
      
      private var curFuncTempInfos:PlanesFuncTemplateInfo;
      
      public function PlanesUseSkillFrame()
      {
         super();
         initView();
         addEvent();
         __funcBuyBackHandler(null);
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PlanesUseSkillFrame.back");
         selectSkillText = ComponentFactory.Instance.creatComponentByStylename("PlanesUseSkillFrame.selectSkillText");
         energyBuyBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesUseSkillFrame.energyBuyBtn");
         pointBuyBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesUseSkillFrame.pointBuyBtn");
         upShowView = ComponentFactory.Instance.creatCustomObject("PlanesUseSkillFrame.upShowView",[1]);
         downShowView = ComponentFactory.Instance.creatCustomObject("PlanesUseSkillFrame.downShowView",[2]);
         addToContent(back);
         addToContent(upShowView);
         addToContent(energyBuyBtn);
         addToContent(pointBuyBtn);
         addToContent(downShowView);
         addToContent(selectSkillText);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         energyBuyBtn.addEventListener("click",__energyBuyClickHandler);
         pointBuyBtn.addEventListener("click",__pointBuyClickHandler);
         PlanesWarManager.instance.addEventListener("PLANES_FUNCBUY_BACK",__funcBuyBackHandler);
         PlanesWarManager.instance.addEventListener("PLANES_FUNCSELECT_CHANGE",__funcSelectChangeHandler);
         PlanesWarManager.instance.addEventListener("PLANES_LAYERLIST_UPDATE",__funcBuyBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(energyBuyBtn)
         {
            energyBuyBtn.removeEventListener("click",__energyBuyClickHandler);
         }
         if(pointBuyBtn)
         {
            pointBuyBtn.removeEventListener("click",__pointBuyClickHandler);
         }
         PlanesWarManager.instance.removeEventListener("PLANES_FUNCBUY_BACK",__funcBuyBackHandler);
         PlanesWarManager.instance.removeEventListener("PLANES_FUNCSELECT_CHANGE",__funcSelectChangeHandler);
         PlanesWarManager.instance.removeEventListener("PLANES_LAYERLIST_UPDATE",__funcBuyBackHandler);
      }
      
      private function __funcBuyBackHandler(param1:PlanesWarEvent) : void
      {
         model.skillSelectedTempId = model.getShowDataByType(1)[0];
         model.skillSelectedTempId == 0 ? (model.skillSelectedType = 0) : (int(model.skillSelectedType = 1));
         upShowView.refreshView();
         downShowView.refreshView();
         refreshView();
      }
      
      private function __funcSelectChangeHandler(param1:PlanesWarEvent) : void
      {
         upShowView.refreshView();
         downShowView.refreshView();
         refreshView();
      }
      
      private function __energyBuyClickHandler(param1:MouseEvent) : void
      {
         if(!curFuncTempInfos)
         {
            return;
         }
         if(model.energyLeft <= curFuncTempInfos.NeedEnergy)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planes.PlanesUseSkillFrame.noEnergyAlert"));
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("planes.PlanesUseSkillFrame.energyBuyContent",curFuncTempInfos.NeedEnergy);
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         SharedManagerHelper.ins.needAlert("planes.PlanesUseSkillFrame.energyBuyAlert",energyBuyResult,_loc2_,_loc3_);
      }
      
      private function energyBuyResult() : void
      {
         PlanesWarManager.instance.sendPlanesOpMsg(3,[curFuncTempInfos.TemplateId,3]);
      }
      
      private function __pointBuyClickHandler(param1:MouseEvent) : void
      {
         if(!curFuncTempInfos)
         {
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("planes.PlanesUseSkillFrame.pointBuyContent",curFuncTempInfos.NeedPoint);
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         SharedManagerHelper.ins.needAlert("planes.PlanesUseSkillFrame.pointBuyAlert",pointBuyResult,_loc2_,_loc3_,"");
      }
      
      private function pointBuyResult(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc2_ >= curFuncTempInfos.NeedPoint)
         {
            _loc3_ = param1 ? 2 : 1;
            PlanesWarManager.instance.sendPlanesOpMsg(3,[curFuncTempInfos.TemplateId,_loc3_]);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:Array = null;
         curFuncTempInfos = TempleteManager.instance.planesFuncTemplateCate.getTemplateByID(model.skillSelectedTempId);
         energyBuyBtn.enable = pointBuyBtn.enable = false;
         if(curFuncTempInfos)
         {
            selectSkillText.text = curFuncTempInfos.Desc;
            if(model.skillSelectedType == 1)
            {
               energyBuyBtn.enable = pointBuyBtn.enable = true;
            }
         }
         else
         {
            selectSkillText.text = "";
         }
         if(model.planesWarInfo.layerInfo)
         {
            _loc1_ = model.planesWarInfo.layerInfo.funcArray;
            if(_loc1_.length >= 2)
            {
               energyBuyBtn.visible = false;
               pointBuyBtn.x = 105;
            }
            else
            {
               energyBuyBtn.visible = true;
               pointBuyBtn.x = 190;
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("planes.PlanesUseSkillFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.skillSelectedType = 0;
         model.skillSelectedTempId = 0;
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(selectSkillText);
         selectSkillText = null;
         ObjectUtils.disposeObject(energyBuyBtn);
         energyBuyBtn = null;
         ObjectUtils.disposeObject(pointBuyBtn);
         pointBuyBtn = null;
         ObjectUtils.disposeObject(upShowView);
         upShowView = null;
         ObjectUtils.disposeObject(downShowView);
         downShowView = null;
         super.dispose();
      }
   }
}

