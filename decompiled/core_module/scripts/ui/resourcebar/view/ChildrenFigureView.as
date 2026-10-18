package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildrenFigureView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _icon1:BaseIconView;
      
      private var _icon2:BaseIconView;
      
      private var _data:ChildData;
      
      private var _filter:IFilterFormat;
      
      private var _childList:ChildrenSortList;
      
      private var _petList:PetSortList;
      
      private var _childStrip:StripView;
      
      private var _petStrip:StripView;
      
      private var _noChildStrip:StripView;
      
      private var _noPetStrip:StripView;
      
      private var _childAlertImage:Image;
      
      private var _petAlertImage:Image;
      
      private var _childAlertStrip:StripView;
      
      private var _petAlertStrip:StripView;
      
      private var childType:int;
      
      public function ChildrenFigureView(param1:int)
      {
         super();
         childType = param1;
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.ChildFigureBack");
         _icon1 = ComponentFactory.Instance.creatCustomObject("resoueceBar.ChildrenIcon");
         _icon2 = ComponentFactory.Instance.creatCustomObject("resoueceBar.ChildrenIcon2");
         _childStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.ChildrenIconStrip");
         _petStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.ChildrenIconStrip2");
         _noChildStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.noChildStrip");
         _noPetStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.figureCoverStrip");
         _childAlertImage = ComponentFactory.Instance.creatComponentByStylename("ChildrenFigureView.childAlertImage");
         _petAlertImage = ComponentFactory.Instance.creatComponentByStylename("ChildrenFigureView.petAlertImage");
         _childAlertStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.childAlertStrip");
         _petAlertStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.petAlertStrip");
         _filter = new UIFilter();
         _icon1.mask = createSprite();
         _icon1.useHandCursor = true;
         _icon1.buttonMode = true;
         _icon2.mask = createSprite2();
         _icon2.useHandCursor = true;
         _icon2.buttonMode = true;
         addChild(_back);
         addChild(_icon1);
         addChild(_icon2);
         _childStrip.setCircleArea(30,27,20);
         _childStrip.buttonMode = true;
         _petStrip.setCircleArea(66,35,15);
         _petStrip.buttonMode = true;
         _noChildStrip.setCircleArea(30,27,20);
         _noChildStrip.buttonMode = true;
         _noPetStrip.setCircleArea(66,35,15);
         _noPetStrip.buttonMode = true;
         addChild(_childStrip);
         addChild(_petStrip);
         addChild(_noChildStrip);
         addChild(_noPetStrip);
         addChild(_childAlertStrip);
         _childAlertStrip.addChild(_childAlertImage);
         addChild(_petAlertStrip);
         _petAlertStrip.addChild(_petAlertImage);
         __heroLevelUpdate(null);
      }
      
      private function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(30,27,20);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createSprite2() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(66,35,15);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView(param1:Boolean = false) : void
      {
         var _loc2_:String = _data ? IconFactory.getChildrenHeadSmallIcon(_data.job,_data.growthGrade) : null;
         if(param1 || _icon1.icon != _loc2_)
         {
            _icon1.icon = _loc2_;
         }
         _loc2_ = _data && petData ? IconFactory.getPetHeadSmallIcon(petData.templateId) : null;
         if(param1 || _icon2.icon != _loc2_)
         {
            _icon2.icon = _loc2_;
         }
         if(_data)
         {
            _childStrip.visible = true;
            _noChildStrip.visible = false;
            _childStrip.tipData = _data;
            if(!petData)
            {
               if(!checkHasPet())
               {
                  _noPetStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.PetFigureView.noPet");
               }
               else
               {
                  _noPetStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.PetFigureView.clickOpen");
               }
               _noPetStrip.visible = true;
               _petStrip.tipData = null;
            }
            else
            {
               _noPetStrip.visible = false;
               _petStrip.visible = true;
               _petStrip.tipData = petData;
               _noPetStrip.tipData = null;
            }
         }
         else
         {
            _childStrip.visible = false;
            _petStrip.visible = false;
            _noPetStrip.visible = true;
            _noChildStrip.visible = true;
            _childStrip.tipData = null;
            _petStrip.tipData = null;
            _noPetStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noSelectChild");
            if(childType == 1 && !checkHasChild())
            {
               _noChildStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noChild1");
            }
            else if(childType == 2 && !checkHasAwakeChild())
            {
               _noChildStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noChild2");
            }
            _noChildStrip.tipData = LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.clickOpen");
         }
         __heroLevelUpdate(null);
      }
      
      public function checkChangeChild() : Boolean
      {
         var _loc1_:Vector.<ChildData> = ChildManager.instance.model.childList;
         if(_loc1_.length == 1 && _loc1_[0].fightUserId == playerModel.userInfo.userId)
         {
            return false;
         }
         return true;
      }
      
      public function checkHasPet() : Boolean
      {
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         return _loc1_.length > 0;
      }
      
      public function checkHasChild() : Boolean
      {
         return ChildManager.instance.model.childList.length > 0;
      }
      
      public function checkHasAwakeChild() : Boolean
      {
         return childModel.getHasAwakeChildList().length > 0;
      }
      
      public function get petData() : PetData
      {
         var _loc2_:int = 0;
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].isChildWar == childType)
            {
               return _loc1_[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function addEvent() : void
      {
         _icon1.addEventListener("mouseOver",__icon1MouseOverHandler);
         _icon1.addEventListener("mouseOut",__icon1MouseOutHandler);
         _childStrip.addEventListener("click",__icon1MouseClickHandler);
         _noChildStrip.addEventListener("click",__icon1MouseClickHandler);
         _icon2.addEventListener("mouseOver",__icon2MouseOverHandler);
         _icon2.addEventListener("mouseOut",__icon2MouseOutHandler);
         _petStrip.addEventListener("click",__icon2MouseClickHandler);
         _noPetStrip.addEventListener("click",__icon2MouseClickHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__heroLevelUpdate);
      }
      
      private function removeEvent() : void
      {
         _icon1.removeEventListener("mouseUp",__icon1MouseOverHandler);
         _icon1.removeEventListener("mouseOut",__icon1MouseOutHandler);
         _childStrip.removeEventListener("click",__icon1MouseClickHandler);
         _noChildStrip.removeEventListener("click",__icon1MouseClickHandler);
         _icon2.removeEventListener("mouseOver",__icon2MouseOverHandler);
         _icon2.removeEventListener("mouseOut",__icon2MouseOutHandler);
         _petStrip.removeEventListener("click",__icon2MouseClickHandler);
         _noPetStrip.removeEventListener("click",__icon2MouseClickHandler);
         thane.removeEventListener("THANE_LEVEL_UPDATE",__heroLevelUpdate);
      }
      
      private function __heroLevelUpdate(param1:PlayerEvent) : void
      {
         if(thane.grades >= 70)
         {
            _childAlertStrip.visible = false;
            _petAlertStrip.visible = false;
         }
         else
         {
            _childAlertStrip.visible = true;
            _petAlertStrip.visible = true;
            _childStrip.visible = false;
            _petStrip.visible = false;
            _noChildStrip.visible = false;
            _noPetStrip.visible = false;
            _childAlertStrip.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",70);
            _petAlertStrip.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",70);
         }
      }
      
      private function __icon1MouseOverHandler(param1:MouseEvent) : void
      {
         _filter.setLightingFilter(_icon1);
      }
      
      private function __icon1MouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_icon1);
      }
      
      private function __icon2MouseOverHandler(param1:MouseEvent) : void
      {
         _filter.setLightingFilter(_icon2);
      }
      
      private function __icon2MouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_icon2);
      }
      
      private function __icon1MouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         if(!checkChangeChild())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.PetFigureView.noChangeChild"));
            return;
         }
         if(_childList)
         {
            _childList.dispose();
            return;
         }
         if(!checkHasChild() && childType == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noChild1"));
            return;
         }
         if(!checkHasAwakeChild() && childType == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noChild2"));
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_childList)
         {
            _childList = new ChildrenSortList(childType);
         }
         _childList.addEventListener("dispose",__onChildListDispose);
         var _loc2_:Point = new Point(_icon1.x,_icon1.y);
         _childList.x = localToGlobal(_loc2_).x + _childStrip.width;
         _childList.y = localToGlobal(_loc2_).y + _childStrip.height - 10;
         LayerManager.Instance.addToLayer(_childList,7);
      }
      
      private function __onChildListDispose(param1:Event) : void
      {
         _childList.removeEventListener("dispose",__onChildListDispose);
         _childList = null;
      }
      
      private function __icon2MouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         if(!_data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noSelectChild"));
            return;
         }
         if(!checkHasPet())
         {
            return;
         }
         if(_petList)
         {
            _petList.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_petList)
         {
            _petList = new PetSortList(childType + 1);
         }
         _petList.addEventListener("dispose",__onPetListDispose);
         var _loc2_:Point = new Point(_icon2.x,_icon2.y);
         _petList.x = localToGlobal(_loc2_).x + _petStrip.width;
         _petList.y = localToGlobal(_loc2_).y + _petStrip.height - 10;
         LayerManager.Instance.addToLayer(_petList,7);
      }
      
      private function __onPetListDispose(param1:Event) : void
      {
         _petList.removeEventListener("dispose",__onPetListDispose);
         _petList = null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon1);
         _icon1 = null;
         ObjectUtils.disposeObject(_icon2);
         _icon2 = null;
         ObjectUtils.disposeObject(_childStrip);
         _childStrip = null;
         ObjectUtils.disposeObject(_petStrip);
         _petStrip = null;
         ObjectUtils.disposeObject(_noPetStrip);
         _noPetStrip = null;
         ObjectUtils.disposeObject(_noChildStrip);
         _noChildStrip = null;
         ObjectUtils.disposeObject(_childAlertImage);
         _childAlertImage = null;
         ObjectUtils.disposeObject(_childAlertStrip);
         _childAlertStrip = null;
         ObjectUtils.disposeObject(_petAlertImage);
         _petAlertImage = null;
         ObjectUtils.disposeObject(_petAlertStrip);
         _petAlertStrip = null;
         _data = null;
         _filter = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

