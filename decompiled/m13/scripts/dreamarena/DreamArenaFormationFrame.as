package dreamarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dreamarena.item.DreamArenaFormationItem;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   
   public class DreamArenaFormationFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _bottoms:Array;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _fontBtn1:SelectedIconTextButton;
      
      private var _fontBtn2:SelectedIconTextButton;
      
      private var _backBtn1:SelectedIconTextButton;
      
      private var _backBtn2:SelectedIconTextButton;
      
      private var _saveBtn:BaseButton;
      
      private var _thanePos:int;
      
      private var _childPos:int;
      
      private var _slavedChildPos:int;
      
      private var heroPosArr:Array = [4,7,6,9];
      
      public function DreamArenaFormationFrame()
      {
         super();
         _thanePos = selectInfo.heroFightPos;
         initView();
         initEvent();
         checkPos();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,543,496);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:DreamArenaFormationItem = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.common.formationBg");
         _fontBtn1 = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.fontBtn1");
         _fontBtn2 = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.fontBtn2");
         _backBtn1 = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.backBtn1");
         _backBtn2 = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.backBtn2");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaFormationFrame.saveBtn");
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_fontBtn1);
         _tabGroup.addSelectItem(_fontBtn2);
         _tabGroup.addSelectItem(_backBtn1);
         _tabGroup.addSelectItem(_backBtn2);
         addToContent(_border);
         addToContent(_bg);
         addToContent(_fontBtn1);
         addToContent(_fontBtn2);
         addToContent(_backBtn1);
         addToContent(_backBtn2);
         addToContent(_saveBtn);
         _fontBtn1.text = LanguageMgr.GetTranslation("army.LineUpView.fontBtn1.text");
         _fontBtn2.text = LanguageMgr.GetTranslation("army.LineUpView.fontBtn2.text");
         _backBtn1.text = LanguageMgr.GetTranslation("army.LineUpView.backBtn1.text");
         _backBtn2.text = LanguageMgr.GetTranslation("army.LineUpView.backBtn2.text");
         _bottoms = [];
         var _loc1_:Array = [{
            "x":217,
            "y":142
         },{
            "x":175,
            "y":190
         },{
            "x":132,
            "y":247
         },{
            "x":82,
            "y":307
         },{
            "x":411,
            "y":142
         },{
            "x":378,
            "y":190
         },{
            "x":337,
            "y":247
         },{
            "x":282,
            "y":307
         }];
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new DreamArenaFormationItem(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addToContent(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
         _tabGroup.selectIndex = heroPosArr.indexOf(_thanePos);
      }
      
      private function initEvent() : void
      {
         _tabGroup.addEventListener("change",__updateHeroPosHandler);
         _saveBtn.addEventListener("click",__saveBtnClickHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__updateHeroPosHandler);
         }
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveBtnClickHandler);
         }
         removeEventListener("response",__frameResponse);
      }
      
      private function __saveBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         DreamArenaManager.instance.sendHeroPosSelect(_thanePos);
         dispose();
      }
      
      private function __updateHeroPosHandler(param1:Event) : void
      {
         _thanePos = heroPosArr[_tabGroup.selectIndex];
         model.clientSelectDic.add(20,_thanePos);
         cleanItemView();
         updatePosAndView();
      }
      
      private function updatePosAndView() : void
      {
         checkPos();
         refreshView();
      }
      
      private function getItemByPos(param1:int) : DreamArenaFormationItem
      {
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         var _loc2_:int = _loc3_.indexOf(param1);
         if(_loc2_ == -1)
         {
            return _bottoms[0];
         }
         return _bottoms[_loc2_];
      }
      
      private function checkPos() : void
      {
         if(_thanePos == 4)
         {
            _childPos = 6;
            _slavedChildPos = 12;
         }
         else if(_thanePos == 7)
         {
            _childPos = 9;
            _slavedChildPos = 12;
         }
         else if(_thanePos == 6)
         {
            _childPos = 4;
            _slavedChildPos = 10;
         }
         else if(_thanePos == 9)
         {
            _childPos = 7;
            _slavedChildPos = 10;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:DreamArenaFormationItem = null;
         _loc1_ = getItemByPos(_thanePos);
         _loc1_.data = selectInfo.thane;
         if(selectInfo.mainChildData)
         {
            _loc1_ = getItemByPos(_childPos);
            _loc1_.data = selectInfo.mainChildData;
         }
         if(selectInfo.slaveChildData)
         {
            _loc1_ = getItemByPos(_slavedChildPos);
            _loc1_.data = selectInfo.slaveChildData;
         }
         refreshSaveBtn();
      }
      
      private function refreshSaveBtn() : void
      {
         if(formationChange)
         {
            _saveBtn.enable = true;
         }
         else
         {
            _saveBtn.enable = false;
         }
      }
      
      private function get formationChange() : Boolean
      {
         if(model.clientSelectDic[20] && selectInfo.heroFightPos != model.clientSelectDic[20])
         {
            return true;
         }
         return false;
      }
      
      private function cleanItemView() : void
      {
         for each(var _loc1_:DreamArenaFormationItem in _bottoms)
         {
            if(_loc1_.data)
            {
               _loc1_.data = null;
            }
         }
      }
      
      private function get selectInfo() : DreamArenaSelectRoleInfo
      {
         return DreamArenaManager.instance.model.selfInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(formationChange)
               {
                  FrameControllerManager.instance.dreamArenaController.showChangeSaveAlert(20,dispose);
                  break;
               }
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("DreamArenaFormationFrame.titleText.text");
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_fontBtn1)
         {
            ObjectUtils.disposeObject(_fontBtn1);
         }
         _fontBtn1 = null;
         if(_fontBtn2)
         {
            ObjectUtils.disposeObject(_fontBtn2);
         }
         _fontBtn2 = null;
         if(_backBtn1)
         {
            ObjectUtils.disposeObject(_backBtn1);
         }
         _backBtn1 = null;
         if(_backBtn2)
         {
            ObjectUtils.disposeObject(_backBtn2);
         }
         _backBtn2 = null;
         if(_border)
         {
            ObjectUtils.disposeObject(_border);
         }
         _border = null;
         if(_saveBtn)
         {
            ObjectUtils.disposeObject(_saveBtn);
         }
         _saveBtn = null;
         LogicUtils.disposeDisplayCollection(_bottoms);
         _bottoms = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         model.clientSelectDic.del(20);
         super.dispose();
      }
   }
}

