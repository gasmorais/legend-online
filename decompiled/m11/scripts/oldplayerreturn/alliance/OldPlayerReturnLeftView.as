package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.AllyData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class OldPlayerReturnLeftView extends Component
   {
      
      private var _leftBg:ScaleFrameImage;
      
      private var _iconBtn:IconButton;
      
      private var _findBtn:IconButton;
      
      private var _titleTxt:FilterFrameText;
      
      private var _eternalItem:OldPlayerReturnHeadItem;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _sprite:Sprite;
      
      private var _itemList:Array = [];
      
      private var _timeTxt:FilterFrameText;
      
      private var _line:ScaleFrameImage;
      
      public function OldPlayerReturnLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.leftBg");
         _iconBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.iconBtn");
         _findBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.findBtn");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.titleTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnLeftView.timeTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnLeftView.line");
         _sprite = new Sprite();
         addChild(_leftBg);
         addChild(_iconBtn);
         addChild(_findBtn);
         addChild(_titleTxt);
         addChild(_sprite);
         addChild(_timeTxt);
         _sprite.addChild(_line);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:OldPlayerReturnHeadItem = null;
         var _loc2_:int = 0;
         _eternalItem = new OldPlayerReturnHeadItem();
         _eternalItem.x = 95;
         _eternalItem.y = 105;
         _sprite.addChild(_eternalItem);
         _itemGroup = new SelectedButtonGroup();
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new OldPlayerReturnHeadItem();
            _loc1_.x = 15 + _loc2_ * 80;
            _loc1_.y = 305;
            _sprite.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         if(_itemGroup)
         {
            _itemGroup.addEventListener("change",__itemGroupChangeHandler);
         }
         _iconBtn.addEventListener("click",__btnClickHandler);
         _findBtn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_itemGroup)
         {
            _itemGroup.removeEventListener("change",__itemGroupChangeHandler);
         }
         _iconBtn.removeEventListener("click",__btnClickHandler);
         _findBtn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         OldPlayerReturnManager.instance.sendSearch();
         FrameControllerManager.instance.openControllerByInfo("oldplayerreturn",3);
      }
      
      private function __itemGroupChangeHandler(param1:Event) : void
      {
         var _loc2_:OldPlayerReturnHeadItem = null;
         if(model.isReturnPlayer)
         {
            model.selectedAllyId = _eternalItem.data.userId;
         }
         else
         {
            _loc2_ = _itemList[_itemGroup.selectIndex];
            if(_loc2_.data)
            {
               model.selectedAllyId = _loc2_.data.userId;
            }
         }
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:OldPlayerReturnHeadItem = null;
         var _loc7_:* = 0;
         var _loc6_:int = 0;
         _timeTxt.text = model.revokeDate;
         var _loc1_:Date = DateFormatter.parse(model.revokeDate,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = _loc1_.time;
         if(_loc3_ < playerModel.nowDate)
         {
            _timeTxt.text = "";
         }
         else
         {
            _timeTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnLeftView.timeTxt.text",model.revokeDate);
         }
         if(model.allyList.length == 0)
         {
            _titleTxt.text = "";
            _leftBg.setFrame(1);
            _iconBtn.visible = true;
            _findBtn.visible = true;
            _sprite.visible = false;
         }
         else
         {
            _titleTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnAllianceView.titleTxt.text");
            _leftBg.setFrame(2);
            _iconBtn.visible = false;
            _findBtn.visible = false;
            _sprite.visible = true;
            _line.setFrame(model.allyList.length);
            _loc5_ = 0;
            _itemGroup.removeAllItem();
            _loc7_ = 0;
            for each(_loc2_ in _itemList)
            {
               _loc2_.data = null;
            }
            if(model.isReturnPlayer)
            {
               _loc2_ = _itemList[_loc5_];
               _loc2_.refreshSelf();
               _itemGroup.addSelectItem(_loc2_);
               _loc5_++;
               for each(var _loc4_:AllyData in model.allyList)
               {
                  if(_loc4_.isBinding)
                  {
                     _eternalItem.data = _loc4_.player;
                     _eternalItem.isBinding = _loc4_.isBinding;
                  }
                  else
                  {
                     _loc2_ = _itemList[_loc5_];
                     _loc2_.data = _loc4_.player;
                     _loc2_.isBinding = _loc4_.isBinding;
                     if(_loc2_.data.userId == model.selectedAllyId)
                     {
                        _loc7_ = _loc5_;
                     }
                     _itemGroup.addSelectItem(_loc2_);
                     _loc5_++;
                  }
               }
            }
            else
            {
               _eternalItem.refreshSelf();
               _loc6_ = 0;
               while(_loc6_ < model.allyList.length)
               {
                  _loc2_ = _itemList[_loc6_];
                  _loc2_.data = model.allyList[_loc6_].player;
                  _loc2_.isBinding = model.allyList[_loc6_].isBinding;
                  if(_loc2_.data.userId == model.selectedAllyId)
                  {
                     _loc7_ = _loc6_;
                  }
                  _itemGroup.addSelectItem(_loc2_);
                  _loc6_++;
               }
            }
            _itemGroup.selectIndex = _loc7_;
            __itemGroupChangeHandler(null);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_iconBtn);
         _iconBtn = null;
         ObjectUtils.disposeObject(_findBtn);
         _findBtn = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_eternalItem);
         _eternalItem = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_itemGroup);
         _itemGroup = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _itemList = null;
      }
   }
}

