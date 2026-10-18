package farm.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.ShowMountMsgInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.WildSoulInfo;
   
   public class FarmMountSelectMenu extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _listPanel:ScrollPanel;
      
      private var _list:Vector.<FarmMountListItemView>;
      
      private var _noMountTxt:FilterFrameText;
      
      public function FarmMountSelectMenu()
      {
         super();
         if(stage)
         {
            initView();
            addEvent();
         }
         else
         {
            addEventListener("addedToStage",__onStage);
         }
      }
      
      private function __onStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onStage);
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:FarmMountListItemView = null;
         this.titleText = LanguageMgr.GetTranslation("farmSelectMountMeun.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.back");
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("farm.PetVBox");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.ScrollPanel");
         _listPanel.vScrollProxy = 1;
         addToContent(_bg);
         addToContent(_listPanel);
         _listPanel.mouseEnabled = false;
         _vBox.mouseEnabled = false;
         var _loc2_:Array = remainMount();
         _list = new Vector.<FarmMountListItemView>();
         _listPanel.beginChanges();
         if(_loc2_.length == 0)
         {
            _noMountTxt = ComponentFactory.Instance.creatComponentByStylename("farm.mount.nomountTxt");
            addToContent(_noMountTxt);
            _noMountTxt.text = LanguageMgr.GetTranslation("farm.mountSelected.noMount");
         }
         for each(var _loc3_:WildSoulInfo in _loc2_)
         {
            if(!(!_loc3_ || !_loc3_.template || _loc3_.template.TemplateId == 0 || _loc3_.template.TemplateName == null))
            {
               _loc1_ = new FarmMountListItemView();
               _loc1_.mountData = _loc3_;
               _list.push(_loc1_);
               _vBox.addChild(_loc1_);
            }
         }
         _listPanel.setView(_vBox);
         _listPanel.commitChanges();
         if(_list.length > 5)
         {
            this.width = 260;
            this.height = 360;
            _bg.height = 293;
         }
         else if(_list.length < 1)
         {
            this.width = 250;
            _bg.height = _vBox.height + 30;
            this.height = _vBox.height + 95;
         }
         else
         {
            this.width = 250;
            _bg.height = _vBox.height + 10;
            this.height = _vBox.height + 75;
         }
      }
      
      private function remainMount() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:Dictionary = MountsManager.instance.avatarList.data;
         for each(var _loc2_:WildSoulInfo in _loc3_)
         {
            if(!isShow(_loc2_.templateId))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function isShow(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:ShowMountMsgInfo = null;
         var _loc2_:Boolean = false;
         var _loc5_:Array = FarmManager.instance.model.showMountMsgInfo;
         while(_loc4_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc4_];
            if(param1 == _loc3_.templateId)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         if(_list && _list.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _list.length)
            {
               _list[_loc1_].addEventListener("click",__clickHandler);
               _list[_loc1_].addEventListener("rollOver",__mouseOverHandler);
               _list[_loc1_].addEventListener("rollOut",__mouseOutHandler);
               _loc1_++;
            }
         }
         this.addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         if(_list && _list.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _list.length)
            {
               _list[_loc1_].removeEventListener("click",__clickHandler);
               _list[_loc1_].removeEventListener("rollOver",__mouseOverHandler);
               _list[_loc1_].removeEventListener("rollOut",__mouseOutHandler);
               _loc1_++;
            }
         }
         this.removeEventListener("response",__frameResponse);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmMountListItemView = param1.currentTarget as FarmMountListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmMountListItemView = param1.currentTarget as FarmMountListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOut();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmMountListItemView = param1.currentTarget as FarmMountListItemView;
         if(_loc2_)
         {
            _loc2_.mouseClick();
         }
         dispose();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FarmManager.instance.model.currentMountPos = -1;
         ObjectUtils.disposeObject(_noMountTxt);
         _noMountTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

