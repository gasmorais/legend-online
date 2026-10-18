package child.emblem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.children.PosMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EmblemInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildEmblemChangeView extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _group:SelectedButtonGroup;
      
      private var _needTxt:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _btnBox1:HBox;
      
      private var _btnBox2:HBox;
      
      private var _pos:int;
      
      private var _clickIndex:int;
      
      private var _filter:SimpleBuildingFilter;
      
      private var _data:EmblemInfo;
      
      private var _attriList:Array = [2,3,4,5,6,7];
      
      private var _txtList:Vector.<FilterFrameText>;
      
      private var _btnList:Vector.<SelectedIconButton>;
      
      private var _type:int;
      
      public function ChildEmblemChangeView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,350,270);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.bg");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.needTxt");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.changeBtn");
         _btnBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.btnBox1");
         _btnBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.btnBox2");
         _group = new SelectedButtonGroup();
         _filter = new SimpleBuildingFilter();
         _txtList = new Vector.<FilterFrameText>();
         _btnList = new Vector.<SelectedIconButton>();
         addToContent(_bg);
         addToContent(_btnBox1);
         addToContent(_btnBox2);
         addToContent(_needTxt);
         addToContent(_changeBtn);
      }
      
      private function unitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_btnBox1);
         _btnBox1 = null;
         ObjectUtils.disposeObject(_btnBox2);
         _btnBox2 = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         LogicUtils.disposeDisplayCollection(_txtList);
         _txtList = null;
         LogicUtils.disposeDisplayCollection(_btnList);
         _btnList = null;
         _data = null;
         _attriList = null;
      }
      
      private function refreshView() : void
      {
         var _loc5_:SelectedIconButton = null;
         var _loc1_:FilterFrameText = null;
         var _loc2_:int = 0;
         _data = model.selectedChild.emblemList[_pos];
         if(!_data)
         {
            return;
         }
         var _loc3_:int = _attriList.indexOf(_data.resi1);
         if(_loc3_ >= 0)
         {
            _attriList.splice(_loc3_,1);
         }
         _loc3_ = _attriList.indexOf(_data.resi2);
         if(_loc3_ >= 0)
         {
            _attriList.splice(_loc3_,1);
         }
         _loc3_ = _attriList.indexOf(_data.resi3);
         if(_loc3_ >= 0)
         {
            _attriList.splice(_loc3_,1);
         }
         var _loc4_:int = 0;
         if(_attriList.length < 4)
         {
            _loc4_ = 0;
            while(_loc4_ < _attriList.length)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.selectedBtn");
               _loc5_.selectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _loc5_.unselectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _btnBox1.addChild(_loc5_);
               _group.addSelectItem(_loc5_);
               _btnList.push(_loc5_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.nameTxt");
               _loc1_.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.name" + _attriList[_loc4_]);
               _loc1_.x = _loc5_.x + _btnBox1.x;
               _loc1_.y = _loc5_.y + 80;
               addToContent(_loc1_);
               _txtList.push(_loc1_);
               _loc4_++;
            }
         }
         else if(_attriList.length == 4)
         {
            _loc4_ = 0;
            while(_loc4_ < _attriList.length)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.selectedBtn");
               _loc5_.selectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _loc5_.unselectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _btnBox1.addChild(_loc5_);
               _group.addSelectItem(_loc5_);
               _btnList.push(_loc5_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.nameTxt");
               _loc1_.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.name" + _attriList[_loc4_]);
               _loc1_.x = _loc5_.x + _btnBox1.x;
               _loc1_.y = _loc5_.y + 80;
               addToContent(_loc1_);
               _txtList.push(_loc1_);
               _loc4_++;
            }
            _needTxt.x = 180;
            _changeBtn.x = 213;
            _bg.width = 502;
            width = 520;
         }
         else
         {
            if(_attriList.length == 5)
            {
               _btnBox2.x = 85;
            }
            _loc4_ = 0;
            while(_loc4_ < 3)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.selectedBtn");
               _loc5_.selectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _loc5_.unselectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _btnBox1.addChild(_loc5_);
               _group.addSelectItem(_loc5_);
               _btnList.push(_loc5_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.nameTxt");
               _loc1_.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.name" + _attriList[_loc4_]);
               _loc1_.x = _loc5_.x + _btnBox1.x - 30;
               _loc1_.y = _loc5_.y + 80;
               addToContent(_loc1_);
               _txtList.push(_loc1_);
               _loc4_++;
            }
            _loc4_ = 3;
            while(_loc4_ < _attriList.length)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.selectedBtn");
               _loc5_.selectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _loc5_.unselectedIconStyle = "ChildEmblemChangeView.selectedBtnIcon" + _attriList[_loc4_];
               _btnBox2.addChild(_loc5_);
               _group.addSelectItem(_loc5_);
               _btnList.push(_loc5_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemChangeView.nameTxt");
               _loc1_.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.name" + _attriList[_loc4_]);
               _loc1_.x = _loc5_.x + _btnBox2.x - 30;
               _loc1_.y = _loc5_.y + 170;
               addToContent(_loc1_);
               _txtList.push(_loc1_);
               _loc4_++;
            }
            _needTxt.y = 200;
            _changeBtn.y = 220;
            _bg.height = 268;
            height = 350;
         }
         if(_data.hasOwnProperty("resi" + (_clickIndex + 1)) && _data["resi" + (_clickIndex + 1)] > 1)
         {
            _loc2_ = 10000 * Math.pow(2,_data["grade" + (_clickIndex + 1)] - 1);
            _needTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.needTxt",_loc2_);
            titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.titleTxt1");
            _changeBtn.iconStyle = "asset.ChildEmblemChangeView.changeBtnIcon";
            _type = 1;
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.titleTxt2");
            _needTxt.text = "";
            _changeBtn.iconStyle = "asset.ChildEmblemTabView.upBtnIcon1";
            _group.removeAllItem();
            _type = 2;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_group)
         {
            _group.addEventListener("change",__selectedHandler);
         }
         if(_changeBtn)
         {
            _changeBtn.addEventListener("click",__changerHandler);
         }
         if(_btnBox1)
         {
            _btnBox1.addEventListener("click",__clickHandler);
         }
         if(_btnBox2)
         {
            _btnBox2.addEventListener("click",__clickHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function removeEVent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_group)
         {
            _group.removeEventListener("change",__selectedHandler);
         }
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changerHandler);
         }
         if(_btnBox1)
         {
            _btnBox1.removeEventListener("click",__clickHandler);
         }
         if(_btnBox2)
         {
            _btnBox2.removeEventListener("click",__clickHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_type == 1)
         {
            return;
         }
         var _loc4_:SelectedIconButton = param1.target as SelectedIconButton;
         if(_loc4_)
         {
            if(_loc4_.selected)
            {
               _loc4_.selected = false;
            }
            else
            {
               _loc2_ = 0;
               _loc3_ = 0;
               while(_loc3_ < _btnList.length)
               {
                  if(_btnList[_loc3_].selected == false)
                  {
                     _loc2_ += 1;
                  }
                  _loc3_++;
               }
               if(_loc2_ <= 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.cannotSelected"));
               }
               else
               {
                  _loc4_.selected = true;
                  _filter.setGlowFilter(_loc4_.selectedIcon);
               }
            }
         }
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         if(model.selectedChild == null)
         {
            dispose();
         }
      }
      
      private function __changerHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc5_:PosMsg = null;
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         if(model.selectedChild)
         {
            if(_type == 1)
            {
               if(_group.selectIndex < 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.noSelected"));
                  return;
               }
               ChildSender.emblemChange(model.selectedChild.childId,_pos,_clickIndex,_attriList[_group.selectIndex]);
            }
            else if(_type == 2)
            {
               _loc2_ = [];
               _loc4_ = 0;
               while(_loc4_ < _btnList.length)
               {
                  if(_btnList[_loc4_].selected)
                  {
                     _loc5_ = new PosMsg();
                     _loc5_.property = _attriList[_loc4_];
                     _loc2_.push(_loc5_);
                  }
                  _loc4_++;
               }
               _loc3_ = [];
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  if(_data.hasOwnProperty("resi" + (_loc4_ + 1)) && _data["resi" + (_loc4_ + 1)] <= 1)
                  {
                     _loc3_.push(_loc4_);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(_loc4_ < _loc2_.length)
                  {
                     _loc2_[_loc4_].order = _loc3_[_loc4_];
                  }
                  _loc4_++;
               }
               if(_loc2_.length <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemChangeView.noSelected"));
                  return;
               }
               ChildSender.emblemSelect(model.selectedChild.childId,_pos,_loc2_);
            }
         }
         dispose();
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _btnList.length)
         {
            if(_btnList[_loc2_].selected)
            {
               _filter.setGlowFilter(_btnList[_loc2_].selectedIcon);
            }
            else
            {
               _filter.setNormalFilter(_btnList[_loc2_].selectedIcon);
            }
            _loc2_++;
         }
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            _pos = param1.frameData.pos;
            _clickIndex = param1.frameData.index;
            refreshView();
            LayerManager.Instance.addToLayer(this,3,true,true,1);
         }
      }
      
      override public function dispose() : void
      {
         removeEVent();
         unitView();
         super.dispose();
      }
   }
}

