package map.campaign.mediator.sacrifice
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import yishi.interfaces.IMediator;
   
   public class SacrificeRoomUIMediator implements IMediator
   {
      
      private var _uiSprite:Sprite;
      
      private var _btnDic:Dictionary;
      
      private var _itemDic:Dictionary;
      
      public function SacrificeRoomUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _uiSprite = new Sprite();
         (param1 as Sprite).addChild(_uiSprite);
         addBtns();
      }
      
      public function unregister(param1:Object) : void
      {
         ObjectUtils.disposeObject(_uiSprite);
         _uiSprite = null;
         removeBtns();
      }
      
      private function addBtns() : void
      {
         var _loc3_:SimpleBitmapButton = null;
         _btnDic = new Dictionary(true);
         _itemDic = new Dictionary(true);
         var _loc2_:Array = CampaignManager.instance.mapView.npcLayer.avatarList;
         for each(var _loc1_:Object in _loc2_)
         {
            _loc3_ = _btnDic[_loc1_];
            if(!_loc3_)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.space.NPCBtn" + _loc1_.nodeInfo.nodeId);
               _loc3_.addEventListener("click",__onClickHandler);
               _loc3_.addEventListener("mouseOver",__onOverHandler);
               _loc3_.addEventListener("mouseOut",__onOutHandler);
               _btnDic[_loc1_] = _loc3_;
            }
            _itemDic[_loc3_] = _loc1_;
            if(!_loc3_.parent)
            {
               _loc3_.x = _loc1_.x - _loc3_.width / 2;
               _loc3_.y = _loc1_.y - _loc3_.height + _loc1_.showNamePosY;
               _uiSprite.addChild(_loc3_);
            }
         }
      }
      
      private function removeBtns() : void
      {
         for each(var _loc1_:SimpleBitmapButton in _btnDic)
         {
            _loc1_.removeEventListener("click",__onClickHandler);
            _loc1_.removeEventListener("mouseOver",__onOverHandler);
            _loc1_.removeEventListener("mouseOut",__onOutHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_] = null;
            delete _itemDic[_loc2_];
         }
         _itemDic = null;
         _btnDic = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:Object = _itemDic[_loc3_];
         _loc2_.attackFun();
         param1.stopPropagation();
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:Object = _itemDic[_loc3_];
         if(_loc2_.hasOwnProperty("mouseOverHandler"))
         {
            _loc2_.mouseOverHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:Object = _itemDic[_loc3_];
         if(_loc2_.hasOwnProperty("mouseOutHandler"))
         {
            _loc2_.mouseOutHandler(param1);
         }
         param1.stopPropagation();
      }
   }
}

