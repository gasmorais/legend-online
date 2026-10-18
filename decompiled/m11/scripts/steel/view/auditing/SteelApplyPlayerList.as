package steel.view.auditing
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.data.SteelUserInfo;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class SteelApplyPlayerList extends Sprite implements Disposeable
   {
      
      private var _allSelect:SelectedCheckButton;
      
      private var _acceptBtn:SelectedCheckButton;
      
      private var _rejectBtn:SelectedCheckButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _infosItemList:Vector.<SteelApplyPlayerItem>;
      
      private var _isAllSelect:Boolean;
      
      private var _perPageNum:int = 8;
      
      private var _controller:SteelController = FrameControllerManager.instance.steelController;
      
      private var _model:SteelModel = _controller.model;
      
      public function SteelApplyPlayerList()
      {
         super();
         initView();
         addEvent();
         initData();
         _controller.sendSteelApplyListReq();
      }
      
      private function initView() : void
      {
         _allSelect = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerAllSelectBtn");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerRejectBtn");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerNextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPageTextStyle");
         _infosItemList = new Vector.<SteelApplyPlayerItem>();
         _allSelect.text = LanguageMgr.GetTranslation("emailII.EmailFrame.allSelect");
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject");
         _acceptBtn.enable = false;
         _rejectBtn.enable = false;
         _pageTxt.text = "";
         addChild(_allSelect);
         addChild(_acceptBtn);
         addChild(_rejectBtn);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         _buttonGroup = new SelectedButtonGroup();
      }
      
      private function initData() : void
      {
         setItemList();
         _model.recruitCurrentPage = 1;
         __refreshPage(null);
      }
      
      private function setItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SteelApplyPlayerItem = null;
         _loc2_ = 0;
         while(_loc2_ < _perPageNum)
         {
            _loc1_ = new SteelApplyPlayerItem();
            _loc1_.y = _loc2_ * 33;
            addChild(_loc1_);
            _infosItemList.push(_loc1_);
            _buttonGroup.addSelectItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function setOperateBtn() : void
      {
         if(checkSelected())
         {
            _acceptBtn.enable = _rejectBtn.enable = true;
         }
         else
         {
            _acceptBtn.enable = _rejectBtn.enable = false;
         }
      }
      
      private function checkSelected() : Boolean
      {
         for each(var _loc1_:SteelApplyPlayerItem in _infosItemList)
         {
            if(_loc1_.isCheck && _loc1_.data)
            {
               return true;
            }
         }
         return false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _prePageBtn = null;
         _nextPageBtn = null;
         _acceptBtn = null;
         _allSelect = null;
         _rejectBtn = null;
      }
      
      private function addEvent() : void
      {
         _allSelect.addEventListener("click",__allSelectHandler);
         _prePageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         _model.addEventListener("STEEL_AUDIT_LIST_CHANGE",__auditListChangeHandler);
         _model.addEventListener("UPDE_RECRUIT_SEARCH_PAGE",__refreshPage);
         NotificationManager.instance.addEventListener("APPLY_PLAYER_ITEM_CLICK",__onItemClick);
      }
      
      private function removeEvent() : void
      {
         _allSelect.removeEventListener("click",__allSelectHandler);
         _prePageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         _model.removeEventListener("STEEL_AUDIT_LIST_CHANGE",__auditListChangeHandler);
         _model.removeEventListener("UPDE_RECRUIT_SEARCH_PAGE",__refreshPage);
         NotificationManager.instance.removeEventListener("APPLY_PLAYER_ITEM_CLICK",__onItemClick);
      }
      
      private function __onItemClick(param1:SteelEvent) : void
      {
         setOperateBtn();
      }
      
      private function __auditListChangeHandler(param1:SteelEvent) : void
      {
         _model.recruitCurrentPage = 1;
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         _isAllSelect = false;
         setAllSelect();
         _buttonGroup.selectIndex = -1;
         var _loc1_:int = (_model.recruitCurrentPage - 1) * _perPageNum;
         _loc2_ = _loc1_;
         while(_loc2_ < _loc1_ + _perPageNum)
         {
            _infosItemList[_loc2_ - _loc1_].data = _loc2_ < _model.auditList.length ? SteelUserInfo(_model.auditList[_loc2_]) : null;
            _loc2_++;
         }
         setNumBtnState();
      }
      
      private function __refreshPage(param1:SteelEvent) : void
      {
         _pageTxt.text = _model.recruitCurrentPage + "/" + _model.recruitListTotalPage;
         setNumBtnState();
      }
      
      private function __allSelectHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _isAllSelect = !_isAllSelect;
         setAllSelect();
      }
      
      private function setAllSelect() : void
      {
         for each(var _loc1_:SteelApplyPlayerItem in _infosItemList)
         {
            if(_isAllSelect)
            {
               if(!_loc1_.data)
               {
                  break;
               }
               _loc1_.isCheck = true;
            }
            else
            {
               _loc1_.isCheck = false;
            }
         }
         setOperateBtn();
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _prePageBtn:
               _model.recruitCurrentPage--;
               break;
            case _nextPageBtn:
               _model.recruitCurrentPage++;
         }
         _pageTxt.text = _model.recruitCurrentPage + "/" + _model.recruitListTotalPage;
         refreshList();
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         var _loc3_:SteelUserInfo = null;
         var _loc5_:int = 0;
         SoundManager.instance.play("022");
         setBtnEnable(false);
         var _loc2_:Array = [];
         for each(var _loc4_:SteelApplyPlayerItem in _infosItemList)
         {
            if(_loc4_.isCheck)
            {
               _loc2_.push(_loc4_.data);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as SteelUserInfo;
            FrameControllerManager.instance.steelController.sendSteelAgreeApply(_loc3_.userId,true);
            _loc5_++;
         }
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         var _loc3_:SteelUserInfo = null;
         var _loc5_:int = 0;
         SoundManager.instance.play("022");
         setBtnEnable(false);
         var _loc2_:Array = [];
         for each(var _loc4_:SteelApplyPlayerItem in _infosItemList)
         {
            if(_loc4_.isCheck)
            {
               _loc2_.push(_loc4_.data);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as SteelUserInfo;
            FrameControllerManager.instance.steelController.sendSteelAgreeApply(_loc3_.userId,false);
            _loc5_++;
         }
      }
      
      private function setNumBtnState() : void
      {
         _prePageBtn.enable = _model.recruitCurrentPage > 1;
         _nextPageBtn.enable = _model.recruitCurrentPage < _model.recruitListTotalPage;
      }
      
      private function setBtnEnable(param1:Boolean) : void
      {
         _acceptBtn.enable = _rejectBtn.enable = param1;
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

