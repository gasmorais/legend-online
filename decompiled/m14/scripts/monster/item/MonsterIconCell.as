package monster.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IDragTarget;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.DragManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterIconCell extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _monsterIcon:BaseIconView;
      
      private var _starHbox:HBox;
      
      private var _lockImage:Image;
      
      private var _alertText:FilterFrameText;
      
      private var _enterWarImage:Image;
      
      private var _exploreWarImage:Image;
      
      public var showStarAlert:Boolean;
      
      public var showType:int;
      
      private var _data:MonsterInfo;
      
      private var preStar:int;
      
      private var _index:int;
      
      private var _filter:IFilterFormat;
      
      public var isNormalFilter:Boolean = true;
      
      public var evolveFrame:Boolean = false;
      
      public function MonsterIconCell(param1:int, param2:Boolean = false)
      {
         super();
         showType = param1;
         showStarAlert = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.back");
         _monsterIcon = ComponentFactory.Instance.creatCustomObject("MonsterIconCell.monsterIcon");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.starHbox");
         _lockImage = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.lockImage");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.alertText");
         _enterWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.enterWarImage");
         _exploreWarImage = ComponentFactory.Instance.creatComponentByStylename("MonsterIconCell.exploreWarImage");
         addChild(_back);
         addChild(_alertText);
         addChild(_monsterIcon);
         addChild(_starHbox);
         addChild(_lockImage);
         addChild(_enterWarImage);
         addChild(_exploreWarImage);
         _filter = new UIFilter();
         _lockImage.visible = false;
         _enterWarImage.visible = false;
         _enterWarImage.scaleX = _enterWarImage.scaleY = 0.6;
         _enterWarImage.mouseEnabled = false;
         _exploreWarImage.visible = false;
         _exploreWarImage.scaleX = _exploreWarImage.scaleY = 0.6;
         _exploreWarImage.mouseEnabled = false;
         _starHbox.mouseChildren = _starHbox.mouseEnabled = false;
         _lockImage.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(_monsterIcon);
         _monsterIcon.addEventListener("interactive_click",__clickHandler);
         _monsterIcon.addEventListener("interactive_double_click",__doubleClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_monsterIcon)
         {
            _monsterIcon.removeEventListener("interactive_click",__clickHandler);
            _monsterIcon.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_monsterIcon);
         }
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:GameDrag = null;
         if(this.data.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterMove.lockAlert"));
            return;
         }
         if(data && !DragManager.getInstance().isDraging)
         {
            SoundManager.instance.play("028",true);
            _loc3_ = getDragIconObj();
            if(!_loc3_)
            {
               return;
            }
            _loc2_ = DragManager.getInstance().starDrag(_monsterIcon,{
               "icon":_loc3_,
               "type":"down"
            });
            _loc2_.data = data;
            _loc2_.onDrop = beDropHitCallBack;
            _loc2_.dropChecks = [MonsterIconCell,IDragTarget,stage];
            this.setGrayFilter();
         }
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc3_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc4_:Bitmap = null;
         var _loc5_:DisplayObject = _monsterIcon.content;
         if(data && _loc5_)
         {
            _loc3_ = new Sprite();
            _loc1_ = _loc5_.getRect(_loc5_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc6_ = new Matrix();
            _loc6_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc5_,_loc6_);
            _loc4_ = new Bitmap(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = _loc2_.width;
            _loc4_.height = _loc2_.height;
            _loc3_.addChild(_loc4_);
            return _loc3_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:MonsterIconCell = null;
         this.setNormalFilter();
         if(param1.dropTarget is MonsterIconCell)
         {
            _loc2_ = param1.dropTarget as MonsterIconCell;
            if(_loc2_.showType == this.showType)
            {
               param1.stopImmediatePropagation();
               return;
            }
            if(_loc2_.data)
            {
               if(this.showType == 1)
               {
                  if(this.data.star != model.selectMonster.star)
                  {
                     param1.stopImmediatePropagation();
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterEvolve.needAlert",model.selectMonster.star,model.selectMonster.star));
                     return;
                  }
                  model.moveMonsterBagToMaterial(this.data);
                  model.moveMaterialToMonsterBag(_loc2_.data,true);
               }
               else
               {
                  if(_loc2_.data.star != model.selectMonster.star)
                  {
                     param1.stopImmediatePropagation();
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterEvolve.needAlert",model.selectMonster.star,model.selectMonster.star));
                     return;
                  }
                  if(_loc2_.data.isLock)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterMove.lockAlert"));
                     return;
                  }
                  model.moveMonsterBagToMaterial(_loc2_.data);
                  model.moveMaterialToMonsterBag(this.data,true);
               }
            }
            else if(this.showType == 1)
            {
               if(evolveFrame)
               {
                  if(this.data.star != model.selectMonster.star || model.monsterMaterialList.length >= model.selectMonster.star)
                  {
                     param1.stopImmediatePropagation();
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterEvolve.needAlert",model.selectMonster.star,model.selectMonster.star));
                     return;
                  }
               }
               model.moveMonsterBagToMaterial(this.data);
            }
            else
            {
               model.moveMaterialToMonsterBag(this.data,true);
            }
            MsgMan.notifyObserver("MONSTER_BAG_MOVE");
         }
         else
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         if(!this.data)
         {
            return;
         }
         if(this.data.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterMove.lockAlert"));
            return;
         }
         if(showType == 1)
         {
            if(evolveFrame)
            {
               if(this.data.star != model.selectMonster.star || model.monsterMaterialList.length >= model.selectMonster.star)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterEvolve.needAlert",model.selectMonster.star,model.selectMonster.star));
                  return;
               }
            }
            model.moveMonsterBagToMaterial(this.data);
         }
         else
         {
            model.moveMaterialToMonsterBag(this.data,true);
         }
         MsgMan.notifyObserver("MONSTER_BAG_MOVE");
         param1.stopPropagation();
      }
      
      public function setGrayFilter() : void
      {
         if(_monsterIcon)
         {
            _filter.setGrayFilter(this);
            isNormalFilter = false;
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_monsterIcon)
         {
            _filter.setNormalFilter(this);
            isNormalFilter = true;
         }
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         _data = param1;
         if(data)
         {
            _enterWarImage.visible = data.enterWar;
            _exploreWarImage.visible = model.exploreMonsterIds.indexOf(data.monsterId) != -1;
            if(_enterWarImage.visible && Boolean(_exploreWarImage.visible))
            {
               _exploreWarImage.x = 9;
            }
            else
            {
               _exploreWarImage.x = 22;
            }
            _monsterIcon.icon = IconFactory.getCommonIconPath(data.tempInfo.Icon);
            _monsterIcon.tipData = data;
            _lockImage.visible = data.isLock;
            if(preStar != data.star)
            {
               _starHbox.removeAllChild();
               _loc3_ = 0;
               while(_loc3_ < data.star)
               {
                  _loc2_ = ComponentFactory.Instance.creatBitmap("asset.MonsterPropView.starBitmap");
                  _loc2_.scaleX = _loc2_.scaleY = 0.75;
                  _starHbox.addChild(_loc2_);
                  _loc3_++;
               }
            }
            preStar = data.star;
         }
         else
         {
            preStar = -1;
            _starHbox.removeAllChild();
            _monsterIcon.icon = null;
            _lockImage.visible = false;
            _enterWarImage.visible = false;
            _exploreWarImage.visible = false;
         }
         if(showType == 2 && evolveFrame)
         {
            if(index <= model.selectMonster.star && showType == 2)
            {
               _alertText.text = LanguageMgr.GetTranslation("MonsterIconCell.needMonster.text",model.selectMonster.star);
               this.filters = [];
            }
            else
            {
               _alertText.text = "";
               this.filters = [UIFilter.getGrayFilter()];
            }
         }
         else
         {
            this.filters = [];
            _alertText.text = "";
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_monsterIcon);
         _monsterIcon = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_enterWarImage);
         _enterWarImage = null;
         ObjectUtils.disposeObject(_exploreWarImage);
         _exploreWarImage = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         _filter = null;
         super.dispose();
      }
   }
}

