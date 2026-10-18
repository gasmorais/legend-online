package consortia.view.myConsortia.chairmanPath.consortiaEmail
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   
   public class EmailConsortiaMemberView extends Sprite implements Disposeable
   {
      
      private var _titleCheckBox:ScaleFrameImage;
      
      private var _scale9Bg:Scale9CornerImage;
      
      private var _titleBg:ScaleBitmapImage;
      
      private var _listPanel:ListPanel;
      
      private var _line:Bitmap;
      
      private var _memberTitleTxt:FilterFrameText;
      
      private var _dutyTitleTxt:FilterFrameText;
      
      private var _confirmBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _isAllSelected:Boolean;
      
      private var _memberList:Array;
      
      private var _memberItemList:Array;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function EmailConsortiaMemberView()
      {
         super();
         initView();
         refreshList();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleCheckBox = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.titleCheckBoxBg");
         _scale9Bg = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.memberListViewBG");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.titleBg");
         _line = ComponentFactory.Instance.creatBitmap("asset.writeemail.emailMemberLine");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.confirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.cancelBtn");
         _memberTitleTxt = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.memberTitleTxt");
         _dutyTitleTxt = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.dutyTitleTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.memberVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("writeemail.emailGroupSend.memberScrollPanel");
         addChild(_scale9Bg);
         addChild(_titleBg);
         addChild(_line);
         addChild(_confirmBtn);
         addChild(_cancelBtn);
         addChild(_memberTitleTxt);
         addChild(_dutyTitleTxt);
         addChild(_titleCheckBox);
         addChild(_scrollPanel);
         _scrollPanel.setView(_vBox);
         _titleCheckBox.setFrame(1);
         _titleCheckBox.buttonMode = true;
         _memberTitleTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.EmailConsortiaMemberView.memberTitleTxt");
         _dutyTitleTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.EmailConsortiaMemberView.dutyTitleTxt");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
      }
      
      private function initEvent() : void
      {
         _titleCheckBox.addEventListener("click",__allSelectedHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         addEventListener("MEMBERLIST_SELECTED_CHANGE",__memberSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         _titleCheckBox.removeEventListener("click",__allSelectedHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         removeEventListener("MEMBERLIST_SELECTED_CHANGE",__memberSelectedHandler);
      }
      
      private function __memberSelectedHandler(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = 0;
         param1.stopPropagation();
         _isAllSelected = true;
         _loc2_ = 0;
         while(_loc2_ < _memberItemList.length)
         {
            if(!_memberItemList[_loc2_].selected)
            {
               _isAllSelected = false;
            }
            _loc2_++;
         }
         if(_isAllSelected)
         {
            _titleCheckBox.setFrame(2);
         }
         else
         {
            _titleCheckBox.setFrame(1);
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<ConsortiaEmailMemberItem> = new Vector.<ConsortiaEmailMemberItem>();
         _loc2_ = 0;
         while(_loc2_ < _memberItemList.length)
         {
            if(_memberItemList[_loc2_].selected)
            {
               _loc3_.push(_memberItemList[_loc2_]);
            }
            _loc2_++;
         }
         dispatchEvent(new ConsortiaEvent("UPDATA_CONSORTIAEMAIL_MEMBERLIST",_loc3_));
         this.visible = false;
      }
      
      private function __allSelectedHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _isAllSelected = !_isAllSelected;
         if(_isAllSelected)
         {
            _titleCheckBox.setFrame(2);
         }
         else
         {
            _titleCheckBox.setFrame(1);
         }
         _loc2_ = 0;
         while(_loc2_ < _memberItemList.length)
         {
            _memberItemList[_loc2_].selected = _isAllSelected;
            _loc2_++;
         }
      }
      
      public function refreshList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaEmailMemberItem = null;
         _memberItemList = [];
         _vBox.removeAllChild();
         _titleCheckBox.setFrame(1);
         _isAllSelected = false;
         _memberList = ConsortiaManager.instance.model.consortiaMemberList.getList();
         _memberList.sortOn("dutyId",16);
         _loc2_ = 1;
         while(_loc2_ < _memberList.length)
         {
            _loc1_ = new ConsortiaEmailMemberItem();
            _loc1_.data = _memberList[_loc2_] as ThaneInfo;
            _vBox.addChild(_loc1_);
            _memberItemList.push(_loc1_);
            _loc2_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _titleCheckBox = null;
         _scale9Bg = null;
         _titleBg = null;
         _listPanel = null;
         _line = null;
         _memberTitleTxt = null;
         _dutyTitleTxt = null;
         _confirmBtn = null;
         _cancelBtn = null;
         _memberList = null;
         _memberItemList = null;
         _vBox = null;
         _scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

