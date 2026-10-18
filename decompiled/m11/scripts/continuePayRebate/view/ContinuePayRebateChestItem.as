package continuePayRebate.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import yishi.utils.NumberViewUtils;
   
   public class ContinuePayRebateChestItem extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _ingot:Image;
      
      private var _hbox:HBox;
      
      private var _moneySP:Sprite;
      
      private var _moneyBitMapData:BitmapData;
      
      private var _finishDay:FilterFrameText;
      
      private var _data:FunnyData;
      
      private var _iconVec:Vector.<ContinuePayRebateChestIcon>;
      
      public function ContinuePayRebateChestItem()
      {
         super();
         _iconVec = new Vector.<ContinuePayRebateChestIcon>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestItem.back");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestItem.hbox");
         _moneySP = ComponentFactory.Instance.creatCustomObject("continuePayRebate.chestItem.monetSP");
         _moneyBitMapData = ComponentFactory.Instance.creatBitmapData("asset.continuePayRebate.rewardItem.Num");
         _ingot = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestItem.ingot");
         _finishDay = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chestItem.finishDay");
         addChild(_back);
         addChild(_ingot);
         addChild(_hbox);
         addChild(_moneySP);
         addChild(_finishDay);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:FunnyData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         createIcon();
         NumberViewUtils.refreshValue(_data.bagList[0].conditionList[0].value,_moneySP,_moneyBitMapData,20,20,12,20,"0123456789");
         _moneySP.x = (155 - (_moneySP.width + _ingot.width)) / 2;
         _finishDay.text = LanguageMgr.GetTranslation("continuePayRebate.mainframe.hasPayDay",param1.bagList[0].finshCount);
      }
      
      private function createIcon() : void
      {
         var _loc1_:ContinuePayRebateChestIcon = null;
         _hbox.disposeAllChildren();
         for each(var _loc2_:FunnyBagData in _data.bagList)
         {
            _loc1_ = new ContinuePayRebateChestIcon();
            _hbox.addChild(_loc1_);
            _iconVec.push(_loc1_);
            _loc1_.data = _loc2_;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_ingot);
         _ingot = null;
         ObjectUtils.disposeAllChildren(_hbox);
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         _moneyBitMapData = null;
         ObjectUtils.disposeObject(_moneySP);
         _moneySP = null;
         ObjectUtils.disposeObject(_finishDay);
         _finishDay = null;
         _data = null;
         _iconVec = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

