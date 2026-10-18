package consortia.view.myConsortia.recruit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ApplyPlayerList extends Sprite implements Disposeable
   {
      
      private var _allSelect:SelectedCheckButton;
      
      private var _acceptBtn:SelectedCheckButton;
      
      private var _rejectBtn:SelectedCheckButton;
      
      private var _data:ConsortiaModel;
      
      private var _rejectApply:SelectedButton;
      
      private var _rejectTxt:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _infosItemList:Vector.<ApplyPlayerItem>;
      
      private var _pageNum:int;
      
      private var _isAllSelect:Boolean;
      
      public function ApplyPlayerList()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         _data.recruitNum = 0;
         _pageNum = 8;
         _allSelect = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerAllSelectBtn");
         _acceptBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerAcceptBtn");
         _rejectBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerRejectBtn");
         _rejectApply = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyRejectBtn");
         _rejectTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyRejectTextStyle");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerPrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerNextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPlayerPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ApplyPageTextStyle");
         _infosItemList = new Vector.<ApplyPlayerItem>();
         _allSelect.text = LanguageMgr.GetTranslation("emailII.EmailFrame.allSelect");
         _acceptBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.accept");
         _rejectBtn.text = LanguageMgr.GetTranslation("friends.view.ToolInviteFriendItem.reject");
         _acceptBtn.enable = false;
         _rejectBtn.enable = false;
         _rejectApply.visible = false;
         _rejectApply.selected = !_data.consortiaInfo.openApp;
         _rejectTxt.visible = false;
         _rejectTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ApplyPlayerList.rejectTxtText");
         _pageTxt.text = "";
         addChild(_allSelect);
         addChild(_acceptBtn);
         addChild(_rejectBtn);
         addChild(_rejectApply);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         _rejectApply.addChild(_rejectTxt);
         _buttonGroup = new SelectedButtonGroup();
      }
      
      private function setOperateBtn() : void
      {
         if(checkSelected() && _data.recruitNum != 0)
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
         for each(var _loc1_:ApplyPlayerItem in _infosItemList)
         {
            if(_loc1_.isCheck && _loc1_.data)
            {
               return true;
            }
         }
         return false;
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("UPDA_APPLY_CONSORTIA_INFO",__onApplyConsortiaInfoUpdata);
         _data.addEventListener("UPDA_CONSORTIA_RIGHTS",__setRights);
         _data.addEventListener("UPDE_RECRUIT_SEARCH_PAGE",__refreshPage);
         _allSelect.addEventListener("click",__allSelectHandler);
         _prePageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
         _acceptBtn.addEventListener("click",__onAcceptHandler);
         _rejectBtn.addEventListener("click",__onRejectHandler);
         _rejectApply.addEventListener("click",__onRejectApplyHandler);
         NotificationManager.instance.addEventListener("APPLY_PLAYER_ITEM_CLICK",__onItemClick);
      }
      
      private function removeEvent() : void
      {
         _data.removeEventListener("UPDA_APPLY_CONSORTIA_INFO",__onApplyConsortiaInfoUpdata);
         _data.removeEventListener("UPDA_CONSORTIA_RIGHTS",__setRights);
         _data.removeEventListener("UPDE_RECRUIT_SEARCH_PAGE",__refreshPage);
         _allSelect.removeEventListener("click",__allSelectHandler);
         _prePageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _acceptBtn.removeEventListener("click",__onAcceptHandler);
         _rejectBtn.removeEventListener("click",__onRejectHandler);
         _rejectApply.removeEventListener("click",__onRejectApplyHandler);
         NotificationManager.instance.removeEventListener("APPLY_PLAYER_ITEM_CLICK",__onItemClick);
      }
      
      private function __onItemClick(param1:ConsortiaEvent) : void
      {
         setOperateBtn();
      }
      
      private function initData() : void
      {
         setItemList();
         FrameControllerManager.instance.consortiaController.model.recruitCurrentPage = 1;
         FrameControllerManager.instance.consortiaController.sendGetConsortiaApplyInfos();
         __onApplyConsortiaInfoUpdata(null);
         __setRights(null);
         __refreshPage(null);
      }
      
      private function setItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ApplyPlayerItem = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ApplyPlayerItem();
            _loc1_.y = _loc2_ * 33;
            addChild(_loc1_);
            _infosItemList.push(_loc1_);
            _buttonGroup.addSelectItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function __onApplyConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         refreshList();
      }
      
      public function sortList() : void
      {
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc1_:int = 0;
         _isAllSelect = false;
         setAllSelect();
         _buttonGroup.selectIndex = -1;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _infosItemList[_loc1_].data = _loc1_ < _data.applyConsortiaList.length ? ThaneInfo(_data.applyConsortiaList[_loc1_]) : null;
            _loc1_++;
         }
         setNumBtnState();
      }
      
      private function __setRights(param1:ConsortiaEvent) : void
      {
         var _loc2_:Boolean = Boolean(FrameControllerManager.instance.consortiaController.getRightsByIndex(33));
         if(_loc2_)
         {
            _rejectApply.visible = true;
            _rejectTxt.visible = true;
         }
         else
         {
            _rejectApply.visible = false;
            _rejectTxt.visible = false;
         }
      }
      
      private function __refreshPage(param1:ConsortiaEvent) : void
      {
         _pageTxt.text = _data.recruitCurrentPage + "/" + _data.recruitListTotalPage;
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
         for each(var _loc1_:ApplyPlayerItem in _infosItemList)
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
         FrameControllerManager.instance.consortiaController.getConsortiaApplyInfos(param1.currentTarget == _prePageBtn);
      }
      
      private function __onAcceptHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         setBtnEnable(false);
         var _loc2_:Array = [];
         for each(var _loc3_:ApplyPlayerItem in _infosItemList)
         {
            if(_loc3_.isCheck)
            {
               _loc2_.push(_loc3_.data);
            }
         }
         FrameControllerManager.instance.consortiaController.consortiaAcceptOrRejectApply(_loc2_,true);
      }
      
      private function __onRejectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         setBtnEnable(false);
         var _loc2_:Array = [];
         for each(var _loc3_:ApplyPlayerItem in _infosItemList)
         {
            if(_loc3_.isCheck)
            {
               _loc2_.push(_loc3_.data);
            }
         }
         FrameControllerManager.instance.consortiaController.consortiaAcceptOrRejectApply(_loc2_,false);
      }
      
      private function setNumBtnState() : void
      {
         _prePageBtn.enable = _data.recruitCurrentPage > 1;
         _nextPageBtn.enable = _data.recruitCurrentPage < _data.recruitListTotalPage;
      }
      
      private function setBtnEnable(param1:Boolean) : void
      {
         _acceptBtn.enable = _rejectBtn.enable = param1;
      }
      
      private function __onRejectApplyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.consortiaController.ifOpenApply(!_rejectApply.selected);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         if(_allSelect)
         {
            ObjectUtils.disposeObject(_allSelect);
         }
         _allSelect = null;
         if(_rejectBtn)
         {
            ObjectUtils.disposeObject(_rejectBtn);
         }
         _rejectBtn = null;
         if(_acceptBtn)
         {
            ObjectUtils.disposeObject(_acceptBtn);
         }
         _acceptBtn = null;
         if(_rejectApply)
         {
            ObjectUtils.disposeObject(_rejectApply);
         }
         _rejectApply = null;
         if(_rejectTxt)
         {
            ObjectUtils.disposeObject(_rejectTxt);
         }
         _rejectTxt = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_prePageBtn)
         {
            ObjectUtils.disposeObject(_prePageBtn);
         }
         _prePageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
         }
         _nextPageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
         }
         _nextPageBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

