package farm.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.FarmInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmPetSelectMeun extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _list:Vector.<FarmPetListItemView>;
      
      private var _currentPetId:int = 0;
      
      public var _currentPos:int = 0;
      
      private var _type:int = 1;
      
      public var selectedPetId:int = 0;
      
      private var _listPanel:ScrollPanel;
      
      public function FarmPetSelectMeun(param1:int, param2:int, param3:int = 1)
      {
         _currentPetId = param1;
         _currentPos = param2;
         _type = param3;
         selectedPetId = param1;
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
         if(_type == 1)
         {
            initPracticeView();
         }
         else
         {
            initGuardView();
         }
      }
      
      private function initPracticeView() : void
      {
         var _loc3_:FarmPetListItemView = null;
         var _loc2_:String = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.back");
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("farm.PetVBox");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.ScrollPanel");
         _listPanel.vScrollProxy = 1;
         addToContent(_bg);
         addToContent(_listPanel);
         _listPanel.mouseEnabled = false;
         _vBox.mouseEnabled = false;
         var _loc4_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         var _loc1_:Array = [];
         _list = new Vector.<FarmPetListItemView>();
         _listPanel.beginChanges();
         for each(var _loc5_:PetData in _loc4_)
         {
            if(!(_loc5_.isEnterWar || _loc5_.petId == _currentPetId || Boolean(_loc5_.isPractice) || _loc5_.isChildWar))
            {
               _loc1_.push(_loc5_);
               _loc3_ = new FarmPetListItemView();
               _loc3_.data = _loc5_;
               _list.push(_loc3_);
               _vBox.addChild(_loc3_);
            }
         }
         _listPanel.setView(_vBox);
         _listPanel.commitChanges();
         if(_list.length == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("FarmPetSelectMeun.noPet01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(_list.length > 5)
         {
            this.width = 250;
            this.height = 360;
            _bg.height = 293;
         }
         else
         {
            this.width = 240;
            _bg.height = _vBox.height + 10;
            this.height = _vBox.height + 75;
         }
         this.titleText = LanguageMgr.GetTranslation("FarmSelectPetMeun.title");
      }
      
      private function initGuardView() : void
      {
         var _loc2_:FarmPetListItemView = null;
         var _loc1_:String = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.back");
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("farm.PetVBox");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("FarmPetSelectMeun.ScrollPanel");
         addToContent(_bg);
         addToContent(_vBox);
         _listPanel.mouseEnabled = false;
         _vBox.mouseEnabled = false;
         var _loc3_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _list = new Vector.<FarmPetListItemView>();
         for each(var _loc4_:PetData in _loc3_)
         {
            if(_loc4_.petId != _currentPetId)
            {
               _loc2_ = new FarmPetListItemView();
               _loc2_.data = _loc4_;
               _list.push(_loc2_);
               _vBox.addChild(_loc2_);
            }
         }
         if(_list.length == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("FarmPetSelectMeun.noPet02");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         if(_list.length > 5)
         {
            this.width = 250;
            this.height = 360;
            _bg.height = 293;
         }
         else
         {
            this.width = 240;
            _bg.height = _vBox.height + 10;
            this.height = _vBox.height + 75;
         }
         this.titleText = LanguageMgr.GetTranslation("FarmSelectPetMeun.title2");
      }
      
      private function uintView() : void
      {
         for each(var _loc1_:FarmPetListItemView in _list)
         {
            _loc1_.dispose();
         }
         _list = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
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
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(!_loc4_ || !_loc4_.data)
         {
            dispose();
            return;
         }
         var _loc6_:FarmInfo = FarmManager.instance.model.myFarm;
         var _loc8_:int = int(_loc6_.userId);
         var _loc3_:int = 0;
         var _loc7_:int = 12;
         if(_type == 1)
         {
            _loc3_ = 15;
            if(_currentPetId > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("FarmPetSelectMeun.hasPet");
            }
            else if(_loc4_.data.isEnterWar)
            {
               _loc2_ = LanguageMgr.GetTranslation("FarmPetSelectMeun.inWar");
            }
            else if(_loc4_.data.isFullExp())
            {
               _loc2_ = LanguageMgr.GetTranslation("FarmPetSelectMeun.isFullExp");
            }
         }
         else
         {
            _loc3_ = 18;
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         var _loc5_:int = int(_loc4_.data.petId);
         FarmManager.instance.sendFarmOper(_loc8_,_loc3_,_currentPos,_loc5_,_loc7_);
         dispose();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:FarmPetListItemView = param1.currentTarget as FarmPetListItemView;
         if(_loc2_)
         {
            _loc2_.mouseOut();
         }
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
         if(isDie)
         {
            return;
         }
         removeEventListener("addedToStage",__onStage);
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

