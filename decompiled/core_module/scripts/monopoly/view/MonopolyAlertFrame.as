package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignNodeInfoMsg;
   import com.road.yishi.proto.campaign.TempMsg;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MonopolyAlertFrame extends Frame
   {
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _contentBg:Image;
      
      private var _eventIcon:BaseIconView;
      
      private var _npcIcon:BaseIconView;
      
      private var _contentTxt:FilterFrameText;
      
      private var _selfFightBtn:IconButton;
      
      private var _friendFightBtn:IconButton;
      
      private var _confirmBtn:IconButton;
      
      private var _payBtn:IconButton;
      
      private var _containerRect:Rectangle;
      
      private var _data:CampaignNodeInfoMsg;
      
      public function MonopolyAlertFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MONOPOLY_ALERT"];
      }
      
      private function initView() : void
      {
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.ScaleBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.ContentBg");
         _eventIcon = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyAlertFrame.EventIcon");
         _npcIcon = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyAlertFrame.NCPIcon",[iconLoaded]);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.ContentTxt");
         _selfFightBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.SelfFightBtn");
         _friendFightBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.FriendFightBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.ConfirmBtn");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyAlertFrame.ConfirmBtn");
         _containerRect = new Rectangle(0,0,78,78);
         addToContent(_scaleBg);
         addToContent(_contentBg);
         addToContent(_eventIcon);
         addToContent(_npcIcon);
         addToContent(_contentTxt);
         addToContent(_selfFightBtn);
         addToContent(_friendFightBtn);
         addToContent(_confirmBtn);
         addToContent(_payBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_eventIcon);
         _eventIcon = null;
         ObjectUtils.disposeObject(_npcIcon);
         _npcIcon = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_selfFightBtn);
         _selfFightBtn = null;
         ObjectUtils.disposeObject(_friendFightBtn);
         _friendFightBtn = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _containerRect = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         _selfFightBtn.addEventListener("click",__selfFightBtnClickHandler);
         _friendFightBtn.addEventListener("click",__friendFightBtnClickHandler);
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
         _payBtn.addEventListener("click",__payBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _selfFightBtn.removeEventListener("click",__selfFightBtnClickHandler);
         _friendFightBtn.removeEventListener("click",__friendFightBtnClickHandler);
         _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
         _payBtn.removeEventListener("click",__payBtnClickHandler);
      }
      
      private function __selfFightBtnClickHandler(param1:MouseEvent) : void
      {
         MonopolySocketOutManager.sendTriggerConfirm();
         dispose();
      }
      
      private function __friendFightBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monopoly",3);
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         MonopolySocketOutManager.sendTriggerConfirm();
         if(_data.type == 6)
         {
            MonopolyManager.instance.hideChest();
         }
         dispose();
      }
      
      private function __payBtnClickHandler(param1:MouseEvent) : void
      {
         MonopolySocketOutManager.sendTriggerConfirm();
      }
      
      private function iconLoaded(param1:BaseIconView = null) : void
      {
         if(_containerRect)
         {
            DisplayUtils.fullInRect(_npcIcon.content,_containerRect,true);
         }
      }
      
      private function refresh() : void
      {
         var _loc3_:TempMsg = null;
         var _loc2_:PawnTemplate = null;
         var _loc1_:GameHeroTempInfo = null;
         if(_data)
         {
            _selfFightBtn.visible = false;
            _friendFightBtn.visible = false;
            _confirmBtn.visible = false;
            _payBtn.visible = false;
            _npcIcon.visible = false;
            _eventIcon.visible = false;
            titleText = LanguageMgr.GetTranslation("monopoly.view.MonopolyAlertFrame.TitleTxt" + _data.type);
            _contentTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyAlertFrame.ContentTxt" + _data.type);
            if(_data.nodeInfo.length > 0)
            {
               _loc3_ = _data.nodeInfo[0] as TempMsg;
            }
            switch(_data.type - 1)
            {
               case 0:
               case 1:
                  if(_loc3_)
                  {
                     _loc2_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc3_.templateId);
                  }
                  if(_loc2_)
                  {
                     _npcIcon.icon = IconFactory.getSoldierIconByIcon(_loc2_.Icon);
                  }
                  _selfFightBtn.visible = true;
                  _friendFightBtn.visible = true;
                  _npcIcon.visible = true;
                  break;
               case 2:
                  if(_loc3_)
                  {
                     _loc1_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc3_.templateId);
                  }
                  if(_loc1_)
                  {
                     _npcIcon.icon = IconFactory.getSoldierIconByIcon(_loc1_.Icon);
                  }
                  _selfFightBtn.visible = true;
                  _friendFightBtn.visible = true;
                  _npcIcon.visible = true;
                  break;
               case 3:
               case 4:
               case 5:
                  _eventIcon.icon = ComponentFactory.Instance.creatComponentByStylename("monopoly.AlertIcon" + _data.type);
                  _confirmBtn.visible = true;
                  _eventIcon.visible = true;
                  break;
               case 10:
                  _eventIcon.icon = ComponentFactory.Instance.creatComponentByStylename("monopoly.AlertIcon" + _data.type);
                  _payBtn.visible = true;
                  _eventIcon.visible = true;
                  showPayTips(_data.nodeInfo);
            }
         }
      }
      
      private function showPayTips(param1:Array) : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:PawnTemplate = null;
         var _loc5_:String = "";
         for each(var _loc4_:TempMsg in param1)
         {
            if(_loc4_.type == 1)
            {
               _loc2_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc4_.templateId);
               if(_loc2_)
               {
                  _loc5_ += LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip02",_loc2_.PawnName,_loc4_.count);
               }
            }
            else
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.templateId);
               if(_loc3_)
               {
                  _loc5_ += LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip02",_loc3_.TemplateName,_loc4_.count);
               }
            }
         }
         if(_loc5_ != "")
         {
            _loc5_ = _loc5_.substring(0,_loc5_.length - 1);
         }
         _contentTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyAlertFrame.ContentTxt" + _data.type,_loc5_);
      }
      
      public function set data(param1:CampaignNodeInfoMsg) : void
      {
         _data = param1;
         refresh();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,0);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

