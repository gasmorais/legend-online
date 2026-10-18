package marry.propose
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryProposeInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.HeadIconCell;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryQuestFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _proposeBtn:IconButton;
      
      private var _data:MarryProposeInfo;
      
      private var _userId:int;
      
      private var _headCell:HeadIconCell;
      
      private var _ringBack:Image;
      
      private var _ringItem:BaseItemView;
      
      private var _name:FilterFrameText;
      
      private var _consortia:FilterFrameText;
      
      private var _grades:FilterFrameText;
      
      private var _input:FilterFrameText;
      
      private var _feelBack:Bitmap;
      
      private var _feelTxt:FilterFrameText;
      
      public function MarryQuestFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,390);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.propose.MarryQuestFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.bg2");
         _proposeBtn = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.proposeBtn");
         _headCell = ComponentFactory.Instance.creatCustomObject("marry.HeadCell");
         _ringBack = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.ringBack");
         _ringItem = ComponentFactory.Instance.creatCustomObject("marry.ringItem");
         _name = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.name");
         _consortia = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.consortia");
         _grades = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.grades");
         _input = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.input");
         _feelBack = ComponentFactory.Instance.creatBitmap("asset.marry.feelBg");
         _feelTxt = ComponentFactory.Instance.creatComponentByStylename("MarryQuestFrame.feelTxt");
         addToContent(_bg);
         addToContent(_proposeBtn);
         _proposeBtn.enable = false;
         addToContent(_headCell);
         addToContent(_ringBack);
         addToContent(_ringItem);
         addToContent(_name);
         addToContent(_consortia);
         addToContent(_grades);
         addToContent(_input);
         _input.text = LanguageMgr.GetTranslation("marry.propose.MarryQuestFrame.inputText");
         addToContent(_feelBack);
         _feelBack.visible = false;
         addToContent(_feelTxt);
         _feelTxt.visible = false;
         _headCell.type = "head";
         setIcon();
      }
      
      private function setIcon() : void
      {
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 208033;
         _ringItem.data = _loc1_;
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            return;
         }
         _proposeBtn.enable = true;
         _name.text = _data.nickNameA;
         _consortia.text = _data.property4;
         _grades.text = _data.property3 + "";
         _headCell.headId = _data.property6;
         if(friendInfo && friendInfo.friendGrade > 0)
         {
            _feelBack.visible = true;
            _feelTxt.visible = true;
            _feelTxt.text = friendInfo.friendGrade + "";
         }
         else
         {
            _feelBack.visible = false;
            _feelTxt.visible = false;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MarryEventType.LOVER_INFO",this,__infoHandler);
         _proposeBtn.addEventListener("click",__proposeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MarryEventType.LOVER_INFO",this,__infoHandler);
         if(_proposeBtn)
         {
            _proposeBtn.removeEventListener("click",__proposeHandler);
         }
      }
      
      private function get friendInfo() : ThaneInfo
      {
         return FriendManager.getInstance().getFriendById(_userId);
      }
      
      private function __proposeHandler(param1:MouseEvent) : void
      {
         if(ArmyManager.instance.thane.grades < 36)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",36));
            dispose();
         }
         else if(_data.property1 == false)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.propose.MarryQuestFrame.hasLover"));
            dispose();
         }
         else if(FilterWordManager.isGotForbiddenWords(_input.text,"name") || Boolean(FilterWordManager.isGotForbiddenWords(_input.text,"chat")))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            dispose();
         }
         else if(GoodsManager.instance.getGoodsNumByTempId(208033) <= 0)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall);
         }
         else
         {
            MarrySender.proposeQuest(_userId,_input.text);
            dispose();
         }
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208033);
         if(_loc2_ == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.propose.MarryQuestFrame.noQuestRing"));
            return;
         }
         _loc1_.data(_loc2_,1);
         _loc1_.show();
      }
      
      private function __rewardHandler(param1:MouseEvent) : void
      {
      }
      
      private function __infoHandler(param1:String, param2:MarryProposeInfo) : void
      {
         if(param1 != "MarryEventType.LOVER_INFO")
         {
            return;
         }
         if(param2.userIdA != _userId)
         {
            return;
         }
         _data = param2;
         refreshView();
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            _userId = int(param1.frameData);
            MarrySender.proposeInfo(_userId);
         }
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_headCell)
         {
            _headCell.dispose();
         }
         _headCell = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_consortia)
         {
            _consortia.dispose();
         }
         _consortia = null;
         if(_grades)
         {
            _grades.dispose();
         }
         _grades = null;
         if(_input)
         {
            _input.dispose();
         }
         _input = null;
         if(_ringItem)
         {
            _ringItem.dispose();
         }
         _ringItem = null;
         if(_proposeBtn)
         {
            _proposeBtn.dispose();
         }
         _proposeBtn = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_feelTxt)
         {
            _feelTxt.dispose();
         }
         _feelTxt = null;
         if(_ringBack)
         {
            _ringBack.dispose();
         }
         _ringBack = null;
         ObjectUtils.disposeObject(_feelBack);
         _feelBack = null;
         _data = null;
         super.dispose();
      }
   }
}

