package emailII.view
{
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.EmailEvent;
   import flash.display.Sprite;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.emailII.EmailModel;
   import yishi.manager.EmailManager;
   import yishi.manager.FrameControllerManager;
   
   public class EmailListView extends Sprite implements Disposeable
   {
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _list:Vector.<EmailItemView>;
      
      private var _mailList:Array;
      
      public function EmailListView()
      {
         super();
         init();
         initEvent();
         refreshData();
         refreshView();
      }
      
      private function get control() : EmailControler
      {
         return FrameControllerManager.instance.emailControler;
      }
      
      private function get model() : EmailModel
      {
         return control.model;
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EmailItemView = null;
         _buttonGroup = new SelectedButtonGroup();
         _list = new Vector.<EmailItemView>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new EmailItemView();
            _list.push(_loc1_);
            _loc1_.x = -14;
            _loc1_.y = (_loc1_.height - 7) * _loc2_;
            addChild(_loc1_);
            _loc1_.group = _buttonGroup;
            _loc1_.addEventListener("EMAIL_SELECTED",__selectHander);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         model.addEventListener("VIEW_EMAILTYPE_CHANGE",__viewChangeHandler);
         model.addEventListener("VIEW_PAGE_CHANGE",__viewChangeHandler);
         model.addEventListener("VIEW_READSTATE_CHANGE",__viewChangeHandler);
         model.addEventListener("DATA_EMAIL_DELETE",__viewChangeHandler);
         model.addEventListener("DATA_EMAIL_UPDATE",__viewUpdateHandler);
         model.addEventListener("DATA_EMAIL_NEW",__viewUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("VIEW_EMAILTYPE_CHANGE",__viewChangeHandler);
         model.removeEventListener("VIEW_PAGE_CHANGE",__viewChangeHandler);
         model.removeEventListener("VIEW_READSTATE_CHANGE",__viewChangeHandler);
         model.removeEventListener("DATA_EMAIL_DELETE",__viewChangeHandler);
         model.removeEventListener("DATA_EMAIL_UPDATE",__viewUpdateHandler);
         model.removeEventListener("DATA_EMAIL_NEW",__viewUpdateHandler);
      }
      
      private function __selectHander(param1:EmailEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:EmailItemView = null;
         var _loc3_:EmailInfo = param1.data as EmailInfo;
         _loc4_ = 0;
         while(_loc4_ < _list.length)
         {
            _loc2_ = _list[_loc4_] as EmailItemView;
            if(_loc2_.data && model.selectedMailId != _loc2_.data.Id)
            {
               _loc2_.selected = false;
            }
            _loc4_++;
         }
      }
      
      private function __viewUpdateHandler(param1:EmailEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:EmailItemView = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _list.length)
         {
            _loc2_ = _list[_loc3_] as EmailItemView;
            if(!_loc2_.data)
            {
               _loc2_.checkBtnSelecte = false;
            }
            else
            {
               _loc4_ = int(param1.list.indexOf(_loc2_.data.Id));
               if(_loc4_ >= 0)
               {
                  _loc2_.data = EmailManager.instance.getEmailById(param1.list[_loc4_]);
                  if(model.currentSelectedList.indexOf(_loc2_.data.Id) >= 0)
                  {
                     _loc2_.checkBtnSelecte = true;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function __viewChangeHandler(param1:EmailEvent) : void
      {
         refreshData();
         refreshView();
      }
      
      private function refreshData() : void
      {
         _mailList = model.currentViewList;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EmailItemView = null;
         var _loc3_:EmailInfo = null;
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            _loc1_ = _list[_loc2_] as EmailItemView;
            _loc3_ = _mailList[_loc2_] as EmailInfo;
            _loc1_.checkBtnSelecte = _loc1_.selected = false;
            if(_loc3_)
            {
               _loc1_.data = _loc3_;
               if(model.currentSelectedList[_loc1_.data.Id])
               {
                  _loc1_.checkBtnSelecte = true;
               }
               if(model.selectedMailId == _loc3_.Id)
               {
                  _loc1_.selected = true;
               }
            }
            else
            {
               _loc1_.data = null;
            }
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:EmailItemView = null;
         removeEvent();
         if(_list)
         {
            while(_list.length > 0)
            {
               _loc1_ = _list.pop();
               if(_loc1_)
               {
                  _loc1_.removeEventListener("EMAIL_SELECTED",__selectHander);
                  _loc1_.dispose();
               }
               _loc1_ = null;
            }
         }
         _buttonGroup = null;
         _mailList = null;
         _list = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

