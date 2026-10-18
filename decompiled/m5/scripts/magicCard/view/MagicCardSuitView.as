package magicCard.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MagicCardEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicCard.view.base.MagicCardSuitItem;
   import mvc.module.card.MagicCardModel;
   import yishi.manager.MagicCardManager;
   import yishi.manager.TempleteManager;
   
   public class MagicCardSuitView extends Sprite implements Disposeable
   {
      
      public static var MAX_COUNT:int = 7;
      
      private var _back:Scale9CornerImage;
      
      private var _upBtn:BaseButton;
      
      private var _downBtn:BaseButton;
      
      private var _itemList:Vector.<MagicCardSuitItem>;
      
      private var _vBox:VBox;
      
      private var _group:SelectedButtonGroup;
      
      private var _mask:Sprite;
      
      public function MagicCardSuitView()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("magicCard.CardSuitViewBack");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.upBtn");
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.downBtn");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardVBox");
         addChild(_back);
         addChild(_upBtn);
         addChild(_downBtn);
         addChild(_vBox);
         initSuitItem();
      }
      
      private function initSuitItem() : void
      {
         var _loc4_:int = 0;
         var _loc1_:MagicCardSuitItem = null;
         _itemList = new Vector.<MagicCardSuitItem>();
         _group = new SelectedButtonGroup();
         var _loc3_:int = int(TempleteManager.instance.magicCardTemplateCate.typeCount);
         var _loc2_:int = _loc3_ <= MAX_COUNT ? MAX_COUNT : _loc3_;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new MagicCardSuitItem();
            if(_loc4_ >= _loc3_)
            {
               _loc1_.type = -1;
            }
            else
            {
               _loc1_.type = _loc4_ + 1;
            }
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc4_++;
         }
         _mask = new Sprite();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(10,26,120,478);
         _mask.graphics.endFill();
         addChild(_mask);
         _vBox.mask = _mask;
      }
      
      private function initEvent() : void
      {
         MagicCardManager.Instance.addEventListener("MAGICCARD_UPDATE",__magicCardUpdateHandler);
         _group.addEventListener("change",__selectedChangHandler);
         _upBtn.addEventListener("click",__clickHandler);
         _downBtn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _upBtn:
            case _downBtn:
         }
      }
      
      protected function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:MagicCardSuitItem = _group.getSelectedItem() as MagicCardSuitItem;
         if(_loc2_)
         {
            MagicCardManager.Instance.sendDispatchEvent("MAGICCARD_SUITINFO",_loc2_.type);
         }
      }
      
      protected function __magicCardUpdateHandler(param1:MagicCardEvent) : void
      {
         updateView();
      }
      
      private function removeEvent() : void
      {
         MagicCardManager.Instance.removeEventListener("MAGICCARD_UPDATE",__magicCardUpdateHandler);
         _group.removeEventListener("change",__selectedChangHandler);
         _upBtn.removeEventListener("click",__clickHandler);
         _downBtn.removeEventListener("click",__clickHandler);
      }
      
      private function updateView() : void
      {
         var _loc1_:MagicCardSuitItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            if(_loc1_.type != -1 && _group.getIndexByItem(_loc1_) == -1)
            {
               _group.addSelectItem(_itemList[_loc2_]);
            }
            _loc2_++;
         }
         var _loc4_:int = int(magicCardModel.getSelectedItem);
         if(_loc4_ == -1 && _group.selectIndex == -1 && _group.itemLength > 0)
         {
            _group.selectIndex = 0;
         }
         else if(_loc4_ != -1)
         {
            _loc2_ = int(_group.getIndexByItem(_itemList[_loc4_ - 1]));
            if(_loc2_ != -1)
            {
               _group.selectIndex = _loc2_;
            }
         }
         for each(var _loc3_:MagicCardSuitItem in _itemList)
         {
            if(_loc3_.type != -1)
            {
               if(magicCardModel.activatedType.indexOf(_loc3_.type) != -1)
               {
                  _loc3_.isActived = true;
               }
               else
               {
                  _loc3_.isActived = false;
               }
            }
         }
         if(_group.selectIndex == -1 && _group.itemLength > 0)
         {
            _group.selectIndex = 0;
         }
      }
      
      private function get magicCardModel() : MagicCardModel
      {
         return MagicCardManager.Instance.cardModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_downBtn);
         _downBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

