package map.space.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import managers.StoreSocketOutManager;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.BaseManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class SpaceUIMediator implements IMediator, IEnterFrame
   {
      
      private var _btnDic:Dictionary;
      
      private var _itemDic:Dictionary;
      
      private var _uiSprite:Sprite;
      
      public function SpaceUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _uiSprite = new Sprite();
         (param1 as Sprite).addChild(_uiSprite);
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("SPACE_NPC_VISIBLE",__refreshNpcBtnHandler);
         StoreSocketOutManager.searchYearBox();
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("SPACE_NPC_VISIBLE",__refreshNpcBtnHandler);
         clearAllBtn();
         ObjectUtils.disposeObject(_uiSprite);
         _uiSprite = null;
      }
      
      private function __refreshNpcBtnHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc6_:Array = BaseManager.instance.checkIsNeedShow();
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = int((_loc6_[_loc4_] as Array)[0]);
            _loc2_ = Boolean((_loc6_[_loc4_] as Array)[1]);
            for each(var _loc3_:Object in _itemDic)
            {
               if(_loc3_.nodeInfo.nodeId == _loc5_)
               {
                  _btnDic[_loc3_].visible = _loc2_;
               }
            }
            _loc4_++;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Array = SpaceManager.instance.controller.npcList;
         if(_loc1_ && _loc1_.length > 0)
         {
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            addAllBtn();
         }
      }
      
      private function addAllBtn() : void
      {
         var _loc4_:SimpleBitmapButton = null;
         var _loc1_:Shape = null;
         _btnDic = new Dictionary(true);
         _itemDic = new Dictionary(true);
         var _loc3_:Array = SpaceManager.instance.controller.npcList;
         for each(var _loc2_:Object in _loc3_)
         {
            if(checkIsNeedInit(_loc2_.nodeInfo))
            {
               if(!(!VersionSwitch.ALCHEMY_WORKSHOP && _loc2_.nodeInfo.nodeId == 8))
               {
                  if(!(!VersionSwitch.ANTAEUS && _loc2_.nodeInfo.nodeId == 47))
                  {
                     if(!(!VersionSwitch.MONSTER_EXPLORE && _loc2_.nodeInfo.nodeId == 48))
                     {
                        if(!(!VersionSwitch.INCREASINGLY_ROAD && _loc2_.nodeInfo.nodeId == 52))
                        {
                           if(!(!VersionSwitch.SHADOW_LAND && _loc2_.nodeInfo.nodeId == 53))
                           {
                              if(!(!VersionSwitch.SAND_BOX && _loc2_.nodeInfo.nodeId == 23))
                              {
                                 if(!(!VersionSwitch.REMAINS_EXPLORE && _loc2_.nodeInfo.nodeId == 16))
                                 {
                                    if(_loc2_.nodeInfo.nodeId != 37)
                                    {
                                       _loc4_ = _btnDic[_loc2_];
                                       if(!_loc4_)
                                       {
                                          _loc4_ = ComponentFactory.Instance.creatComponentByStylename("map.space.NPCBtn" + _loc2_.nodeInfo.nodeId);
                                          _loc1_ = new Shape();
                                          _loc1_.y = 40;
                                          _loc1_.graphics.beginFill(0,0);
                                          _loc1_.graphics.drawRect(0,0,62,90);
                                          _loc1_.graphics.endFill();
                                          _loc4_.addChild(_loc1_);
                                          _loc4_.addEventListener("click",__onClickHandler);
                                          _loc4_.addEventListener("mouseOver",__onOverHandler);
                                          _loc4_.addEventListener("mouseOut",__onOutHandler);
                                          if(!(_loc2_.nodeInfo.nodeId == 8 && !VersionSwitch.LIANJIN))
                                          {
                                             _btnDic[_loc2_] = _loc4_;
                                          }
                                       }
                                       _itemDic[_loc4_] = _loc2_;
                                       if(!_loc4_.parent)
                                       {
                                          _loc4_.x = _loc2_.x - _loc4_.width / 2;
                                          _loc4_.y = _loc2_.y - _loc4_.height - 10 + _loc2_.getTopPosY() + 65;
                                          if(_loc2_.nodeInfo.nodeId == 25 || _loc2_.nodeInfo.nodeId == 16)
                                          {
                                             _loc4_.y = _loc2_.y - _loc4_.height - 10 + _loc2_.getTopPosY() + 55;
                                          }
                                          if(_loc2_.nodeInfo.nodeId == 10)
                                          {
                                             _loc4_.y = _loc2_.y - _loc4_.height - 10 + _loc2_.getTopPosY() + 55;
                                          }
                                          if(!(_loc2_.nodeInfo.nodeId == 8 && !VersionSwitch.LIANJIN))
                                          {
                                             _uiSprite.addChild(_loc4_);
                                          }
                                       }
                                       if(_loc4_)
                                       {
                                          _loc4_.visible = true;
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         __refreshNpcBtnHandler(null);
      }
      
      private function checkIsNeedInit(param1:SpaceNode) : Boolean
      {
         if(param1.info.types == 1)
         {
            return false;
         }
         if(param1.info.types == 191)
         {
            return false;
         }
         return true;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function clearAllBtn() : void
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
            SpaceManager.instance.model.glowTarget = _loc2_ as Sprite;
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

