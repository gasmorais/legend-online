package increasinglyroad.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.IncreasinglyRoadManager;
   import mvc.module.increasingly.IncreasinglyBossInfo;
   import mvc.module.increasingly.IncreasinglyModel;
   import mvc.module.increasingly.IncreasinglyRewardsInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.SharedManagerHelper;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class IncreasinglyroadLayerItemView extends Component
   {
      
      private var _bg:Image;
      
      private var _bg2:Image;
      
      private var _selectedBg:Image;
      
      private var _iconBg:Image;
      
      private var _successBg:Image;
      
      private var _iconHox:HBox;
      
      private var _enterBattleBtn:BaseButton;
      
      private var _uiFilter:UIFilter;
      
      private var _battleMc:MovieClip;
      
      private var _icon:BaseIconView;
      
      private var _isOpen:Boolean;
      
      private var _data:IncreasinglyBossInfo;
      
      private var _flag:Boolean = true;
      
      public var hasGoodItem:Boolean = false;
      
      private var _profileSp:Sprite;
      
      private var _itemCon:Component;
      
      private var _mopupBtn:IconButton;
      
      public function IncreasinglyroadLayerItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.bg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.bg2");
         _icon = ComponentFactory.Instance.creatCustomObject("increasinglyroadLayerItemView.icon");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.selectedBg");
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.iconBg");
         _successBg = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.successBg");
         _iconHox = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.iconHox");
         _battleMc = ComponentFactory.Instance.creatCustomObject("increasinglyroadLayerItemView.battleMc");
         _profileSp = new Sprite();
         _profileSp.mouseEnabled = _profileSp.mouseChildren = false;
         _itemCon = new Component();
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerItemView.mopupBtn");
         _itemCon.addChild(_bg);
         _itemCon.addChild(_bg2);
         _itemCon.addChild(_icon);
         _itemCon.addChild(_selectedBg);
         _itemCon.addChild(_battleMc);
         _itemCon.addChild(_iconBg);
         _itemCon.addChild(_successBg);
         addChild(_itemCon);
         addChild(_iconHox);
         addChild(_profileSp);
         if(VersionSwitch.INCREASINGLE_MOPUP)
         {
            addChild(_mopupBtn);
         }
         _mopupBtn.visible = false;
         _battleMc.visible = false;
         _battleMc.gotoAndStop(1);
         _battleMc.mouseChildren = false;
         _selectedBg.visible = false;
         _uiFilter = new UIFilter();
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("mouseOut",onMouseOut);
         this.addEventListener("click",__itemClickHander);
         _mopupBtn.addEventListener("click",__mopupBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("mouseOut",onMouseOut);
         this.removeEventListener("click",__itemClickHander);
         _mopupBtn.removeEventListener("click",__mopupBtnClickHandler);
      }
      
      private function __mopupBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.enterBattleCostEnergy > model.energy)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("increasinglyroad.view.increasinglyroadLayerItemView.enterBatttle"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("increasinglyroad.IncreasinglyroadLayerItemView.txt",model.enterBattleCostEnergy);
         SharedManagerHelper.ins.needAlert("increasinglyroad.IncreasinglyroadLayerItemView.mopupClick",mopupCallBack,_loc2_,_loc3_);
      }
      
      private function mopupCallBack() : void
      {
         IncreasinglyRoadManager.instance.mopupBattle(_data.index);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(_isOpen)
         {
            _battleMc.visible = true;
            _battleMc.gotoAndPlay(1);
            _selectedBg.visible = true;
            if(model.currentLayer == model.maxLayer && _data.index < model.currentIndex || model.currentLayer < model.maxLayer)
            {
               _mopupBtn.visible = true;
            }
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(_isOpen)
         {
            _battleMc.gotoAndStop(1);
            _battleMc.visible = false;
            _selectedBg.visible = false;
            _mopupBtn.visible = false;
         }
      }
      
      private function get model() : IncreasinglyModel
      {
         return IncreasinglyRoadManager.instance.model;
      }
      
      private function __itemClickHander(param1:MouseEvent) : void
      {
         if(param1.target == _mopupBtn)
         {
            return;
         }
         if(_isOpen)
         {
            if(model.enterBattleCostEnergy > model.energy)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("increasinglyroad.view.increasinglyroadLayerItemView.enterBatttle"));
               return;
            }
            if(_data)
            {
               IncreasinglyRoadManager.instance.enterBattle(_data.index);
            }
         }
      }
      
      public function set data(param1:IncreasinglyBossInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            if(_iconHox && _iconHox.numChildren > 0)
            {
               _iconHox.disposeAllChildren();
            }
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc9_:IncreasinglyRewardsInfo = null;
         var _loc8_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc7_:MovieImage = null;
         var _loc4_:MovieClip = null;
         hasGoodItem = false;
         if(_iconHox && _iconHox.numChildren > 0)
         {
            _iconHox.disposeAllChildren();
         }
         ObjectUtils.disposeAllChildren(_profileSp);
         _icon.icon = IconFactory.getIncreasinglyBossIcon(_data.resource);
         var _loc3_:Array = _data.rewards;
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.length);
            _loc8_ = [];
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new GoodsInfo();
               _loc9_ = _loc3_[_loc5_] as IncreasinglyRewardsInfo;
               if(_loc9_)
               {
                  _loc6_.templateId = _loc9_.tempalteId;
                  _loc6_.count = _loc9_.count;
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("increasinglyroadLayerItemView.BaseItemView");
                  _loc1_.data = _loc6_;
                  _loc1_.buttonMode = false;
                  _iconHox.addChild(_loc1_);
                  if(_loc6_.templateInfo.Profile >= 4)
                  {
                     _loc7_ = ComponentFactory.Instance.creatComponentByStylename("increasinglyroadLayerHboxItemView.LightEffect");
                     hasGoodItem = true;
                     _loc7_.mouseEnabled = false;
                     _loc7_.mouseChildren = false;
                     _loc7_.x = _iconHox.x + _loc1_.x + 15;
                     _loc7_.y = _iconHox.y + _loc1_.y - 23;
                     _profileSp.addChild(_loc7_);
                  }
                  if(_loc6_.templateInfo.Profile >= 4 && Boolean(model.isRefresh))
                  {
                     _loc4_ = ComponentFactory.Instance.creat("asset.increasinglyroadLayerHboxItemView.mc" + _loc6_.templateInfo.Profile);
                     _loc4_.x = _iconHox.x + _loc1_.x + 23;
                     _loc4_.y = _iconHox.y + _loc1_.y + 178;
                     _profileSp.addChild(_loc4_);
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(_isOpen)
         {
            _uiFilter.setNormalFilter(_itemCon);
            this.buttonMode = true;
         }
         else
         {
            _uiFilter.setGrayFilter(_itemCon);
            this.buttonMode = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_iconBg);
         _iconBg = null;
         ObjectUtils.disposeObject(_successBg);
         _successBg = null;
         ObjectUtils.disposeObject(_iconHox);
         _iconHox = null;
         ObjectUtils.disposeObject(_enterBattleBtn);
         _enterBattleBtn = null;
         ObjectUtils.disposeObject(_itemCon);
         _itemCon = null;
         ObjectUtils.disposeAllChildren(_profileSp);
         _profileSp = null;
         ObjectUtils.disposeViolentMc(_battleMc);
         _battleMc = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

