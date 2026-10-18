package steel.view.member
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.data.SteelUserInfo;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   
   public class SteelMemberView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _contentBg:Scale9CornerImage;
      
      private var _titleGap:MutipleImage;
      
      private var _nameTitletTxt:FilterFrameText;
      
      private var _gradsTitleTxt:FilterFrameText;
      
      private var _stateTitleTxt:FilterFrameText;
      
      private var _fightPowerTitleTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _memberTxt:FilterFrameText;
      
      private var _memberNumTxt:FilterFrameText;
      
      private var _itemList:Vector.<SteelMemberItem>;
      
      private var _controller:SteelController;
      
      private var _model:SteelModel;
      
      private var _selectItem:SteelMemberItem;
      
      public function SteelMemberView()
      {
         super();
         _controller = FrameControllerManager.instance.steelController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.Bg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.ContentBg");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.TitileGap");
         _nameTitletTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.NameTitleTxt");
         _gradsTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.GradesTitleTxt");
         _stateTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.StateTitleTxt");
         _fightPowerTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.FightPowerTitleTxt");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.Vbox");
         _memberTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.MemberTipsTxt");
         _memberNumTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelMemberView.MemberNumTipsTxt");
         _nameTitletTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TitleTxt01");
         _gradsTitleTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TitleTxt02");
         _stateTitleTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TitleTxt03");
         _fightPowerTitleTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TitleTxt04");
         _memberTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TipsTxt01");
         _memberNumTxt.text = "";
         addChild(_bg);
         addChild(_contentBg);
         addChild(_titleGap);
         addChild(_nameTitletTxt);
         addChild(_gradsTitleTxt);
         addChild(_stateTitleTxt);
         addChild(_fightPowerTitleTxt);
         addChild(_scrolPanel);
         addChild(_memberTxt);
         addChild(_memberNumTxt);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox);
         _scrolPanel.invalidateViewport();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         setListView();
      }
      
      public function setListView() : void
      {
         var _loc2_:SteelMemberItem = null;
         var _loc5_:* = null;
         _vBox.beginChanges();
         clearList();
         var _loc1_:int = 0;
         if(!_itemList)
         {
            _itemList = new Vector.<SteelMemberItem>();
         }
         var _loc3_:int = 0;
         var _loc4_:Array = _model.userList;
         for each(_loc5_ in _loc4_)
         {
            if(!(!_loc5_.isExist && _loc5_.hostPlayer == 0))
            {
               _loc2_ = new SteelMemberItem();
               _loc2_.data = _loc5_;
               if(_selectItem && _selectItem.data == _loc5_)
               {
                  _selectItem = _loc2_;
               }
               _loc2_.index = _loc3_++;
               _itemList.push(_loc2_);
               _vBox.addChild(_loc2_);
               _loc1_++;
            }
         }
         while(_loc3_ < 9)
         {
            _loc2_ = new SteelMemberItem();
            _loc2_.data = null;
            _loc2_.index = _loc3_++;
            _itemList.push(_loc2_);
            _vBox.addChild(_loc2_);
         }
         _vBox.refreshChildPos();
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
         _loc1_ = Math.min(_loc1_,50);
         _memberNumTxt.text = _loc1_ + " / " + 20;
      }
      
      private function clearList() : void
      {
         for each(var _loc1_:SteelMemberItem in _itemList)
         {
            _loc1_.dispose();
         }
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop();
         }
         _selectItem = null;
      }
      
      private function __selectMemberItemHandler(param1:SteelEvent) : void
      {
         if(_selectItem)
         {
            _selectItem.isSelected = false;
         }
         var _loc3_:SteelUserInfo = param1.data as SteelUserInfo;
         if(!_loc3_)
         {
            return;
         }
         for each(var _loc2_:SteelMemberItem in _itemList)
         {
            if(_loc2_.data == _loc3_)
            {
               _selectItem = _loc2_;
               _loc2_.isSelected = true;
               break;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

