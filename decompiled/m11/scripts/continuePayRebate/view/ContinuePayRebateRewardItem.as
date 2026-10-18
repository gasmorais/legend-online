package continuePayRebate.view
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyRewardData;
   import managers.FunnyManager;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class ContinuePayRebateRewardItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _numSP:Sprite;
      
      private var _numBitMap:BitmapData;
      
      private var _hbox:HBox;
      
      private var _rewardBtn:IconButton;
      
      private var _rewardState:Image;
      
      private var _data:FunnyBagData;
      
      private var _lastActiveId:String;
      
      private var _rewardsPanel:ScrollPanel;
      
      public function ContinuePayRebateRewardItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,230,98);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.rewardItem.back");
         _numSP = ComponentFactory.Instance.creatCustomObject("continuePayRebate.rewardItem.numSP");
         _numBitMap = ComponentFactory.Instance.creatBitmapData("asset.continuePayRebate.rewardItem.Num");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.rewardItem.hbox");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.rewardItem.rewardBtn");
         _rewardState = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.rewardItem.rewardState");
         _rewardsPanel = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.simpleReward.panel");
         addChild(_back);
         addChild(_numSP);
         addChild(_hbox);
         addChild(_rewardBtn);
         addChild(_rewardState);
         _rewardState.mouseChildren = _rewardState.mouseEnabled = false;
         addChild(_rewardsPanel);
         _rewardsPanel.setView(_hbox);
      }
      
      private function initEvent() : void
      {
         _rewardBtn.addEventListener("click",__onBtnClick);
      }
      
      private function removeEvent() : void
      {
         _rewardBtn.removeEventListener("click",__onBtnClick);
      }
      
      protected function __onBtnClick(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         FunnyManager.instance.selectedId = _data.activeId;
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc7_:StarBagCell = null;
         var _loc6_:StarInfo = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         NumberViewUtils.refreshValue(_data.conditionList[0].value,_numSP,_numBitMap,20,20,11,20,"0123456789");
         if(_lastActiveId != _data.activeId)
         {
            _hbox.removeAllChild();
            _lastActiveId = _data.activeId;
            _loc3_ = false;
            if(_data.rewardList.length >= 3)
            {
               _loc3_ = true;
            }
            for each(var _loc4_:FunnyRewardData in _data.rewardList)
            {
               if(_loc4_.temType == 1)
               {
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("continuePayRebate.ContinuePayRebateRewardItem.itemView");
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = _loc4_.temId;
                  _loc5_.count = _loc4_.count;
                  _loc5_.isBinds = _loc4_.isBind;
                  _loc5_.isHideBinds = true;
                  _loc5_.strengthenGrade = _loc4_.strengthenGrade;
                  _loc2_.data = _loc5_;
                  if(_loc3_)
                  {
                     _loc2_.scaleX = _loc2_.scaleY = 0.9;
                  }
                  _hbox.addChild(_loc2_);
               }
               else if(_loc4_.temType == 2)
               {
                  _loc7_ = ComponentFactory.Instance.creatCustomObject("continuePayRebate.rewardItem.StarBagCell");
                  _loc6_ = new StarInfo();
                  _loc6_.template = TempleteManager.instance.starTempalteCate.getTemplateByID(_loc4_.temId);
                  _loc6_.count = _loc4_.count;
                  _loc6_.grade = _loc4_.strengthenGrade;
                  _loc7_.data = _loc6_;
                  _loc7_.acceptDrop = false;
                  _loc7_.lock = false;
                  if(_loc3_)
                  {
                     _loc2_.scaleX = _loc2_.scaleY = 0.9;
                  }
                  _hbox.addChild(_loc7_);
               }
            }
         }
         if(_loc3_)
         {
            _rewardsPanel.y = 33;
         }
         _rewardsPanel.invalidateViewport();
         _rewardBtn.visible = _data.status != 2;
         _rewardBtn.enable = _data.status == 1;
         _rewardState.visible = _data.status == 2;
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numSP);
         _numSP = null;
         _numBitMap = null;
         ObjectUtils.disposeAllChildren(_hbox);
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_rewardState);
         _rewardState = null;
         ObjectUtils.disposeObject(_rewardsPanel);
         _rewardsPanel = null;
         _data = null;
         _lastActiveId = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

