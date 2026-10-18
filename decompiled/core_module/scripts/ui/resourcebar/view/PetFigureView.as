package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetFigureView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _data:PetData;
      
      private var _filter:IFilterFormat;
      
      private var _petList:PetSortList;
      
      private var _petStrip:StripView;
      
      private var _noPetStrip:StripView;
      
      public function PetFigureView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PetFigureBack");
         _icon = ComponentFactory.Instance.creatCustomObject("resoueceBar.PetIcon");
         _petStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.PetIconStrip");
         _noPetStrip = ComponentFactory.Instance.creatCustomObject("resourceBar.figureCoverStrip");
         _filter = new UIFilter();
         _icon.mask = createSprite();
         _icon.useHandCursor = true;
         _icon.buttonMode = true;
         addChild(_back);
         addChild(_icon);
         _petStrip.setCircleArea(20,20,15);
         _petStrip.buttonMode = true;
         _noPetStrip.setCircleArea(20,20,15);
         _noPetStrip.buttonMode = true;
         addChild(_petStrip);
         addChild(_noPetStrip);
      }
      
      private function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(20,20,15);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView(param1:Boolean = false) : void
      {
         var _loc2_:String = _data ? IconFactory.getPetHeadSmallIcon(_data.templateId) : null;
         if(param1 || _icon.icon != _loc2_)
         {
            _icon.icon = _loc2_;
         }
         if(thane.grades >= 50)
         {
            if(!_data)
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
               _noPetStrip.tipData = null;
               _noPetStrip.visible = false;
               _petStrip.tipData = _data;
            }
         }
      }
      
      public function checkChangePet() : Boolean
      {
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         if(_loc1_.length == 1 && _loc1_[0].isEnterWar)
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
      
      private function addEvent() : void
      {
         _icon.addEventListener("mouseOver",__iconMouseOverHandler);
         _icon.addEventListener("mouseOut",__iconMouseOutHandler);
         _petStrip.addEventListener("click",__iconMouseClickHandler);
         _noPetStrip.addEventListener("click",__iconMouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         _icon.removeEventListener("mouseUp",__iconMouseOverHandler);
         _icon.removeEventListener("mouseOut",__iconMouseOutHandler);
         _petStrip.removeEventListener("click",__iconMouseClickHandler);
         _noPetStrip.removeEventListener("click",__iconMouseClickHandler);
      }
      
      private function __iconMouseOverHandler(param1:MouseEvent) : void
      {
         _filter.setLightingFilter(_icon);
      }
      
      private function __iconMouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_icon);
      }
      
      private function __iconMouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         if(!checkHasPet())
         {
            return;
         }
         if(!checkChangePet())
         {
            LanguageMgr.GetTranslation("resourcebar.view.PetFigureView.noChangePet");
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
            _petList = new PetSortList(1);
         }
         _petList.addEventListener("dispose",__onPetListDispose);
         var _loc2_:Point = new Point(_icon.x,_icon.y);
         _petList.x = localToGlobal(_loc2_).x + _petStrip.width;
         _petList.y = localToGlobal(_loc2_).y + _petStrip.height - 10;
         LayerManager.Instance.addToLayer(_petList,7);
      }
      
      private function __onPetListDispose(param1:Event) : void
      {
         _petList.removeEventListener("dispose",__onPetListDispose);
         _petList = null;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get petList() : Array
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.petList;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

