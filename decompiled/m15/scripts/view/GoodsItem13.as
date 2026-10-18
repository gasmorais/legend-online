package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaNewBossModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.ConsortiaNewBossManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class GoodsItem13 extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _buyBtn:IconButton;
      
      private var _name:FilterFrameText;
      
      private var _value:FilterFrameText;
      
      private var _goods:BaseItemView;
      
      private var _currentImg:Bitmap;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _currentTxt:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      private var _isCurrentBuffer:Boolean;
      
      private var _leftTime:String;
      
      private var _countTime:TimeDownView;
      
      public function GoodsItem13()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsItemBg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ItemBuyBtn");
         _name = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsNameTextStyle");
         _value = ComponentFactory.Instance.creatComponentByStylename("shop.ItemGoodsValueTextStyle");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.ItemBaseItemView");
         _currentImg = ComponentFactory.Instance.creatBitmap("asset.shop.currentImg");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("shop.leftTimeTxt");
         _currentTxt = ComponentFactory.Instance.creatComponentByStylename("shop.currentTxt");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("shop.ConsortiaNewBossUpdateTime");
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_buyBtn);
         addChild(_name);
         addChild(_value);
         addChild(_goods);
         _goods.x = 28;
         _goods.y = 28;
         addChild(_currentImg);
         _currentImg.x = 5;
         _currentImg.y = 5;
         addChild(_leftTimeTxt);
         addChild(_currentTxt);
         addChild(_countTime);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
         _buyBtn.addEventListener("click",__clickHandler);
         _countTime.addEventListener("timerDown_complete",_timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         _buyBtn.removeEventListener("click",__clickHandler);
         _countTime.removeEventListener("timerDown_complete",_timeCompleteHandler);
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(consortiaInfo.offer < _data.count)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.buyTips"));
            return;
         }
         if(model.getBufferCount() <= model.bufferBuyCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeCrisis.buyNoTime"));
            return;
         }
         ConsortiaNewBossManager.instance.buyBuffer(_data.templateId);
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         _currentImg.visible = false;
         _countTime.visible = false;
         _currentTxt.visible = false;
         _leftTimeTxt.text = "";
         _currentTxt.text = "";
         model.bufferId = 0;
      }
      
      public function set isCurrentBuffer(param1:Boolean) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         _isCurrentBuffer = param1;
         if(_isCurrentBuffer)
         {
            _currentImg.visible = true;
            _countTime.visible = true;
            _currentTxt.visible = true;
            _loc3_ = Number(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
            _loc2_ = model.bufferStopTime.time / 1000;
            _countTime.timeCount = _loc2_ - _loc3_;
            _leftTimeTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.bufferLeftTime");
            _currentTxt.text = LanguageMgr.GetTranslation("ConsortiaNewBossBufferShopFrame.currentAction");
         }
         else
         {
            _currentImg.visible = false;
            _countTime.visible = false;
            _currentTxt.visible = false;
            _leftTimeTxt.text = "";
            _currentTxt.text = "";
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      private function get model() : ConsortiaNewBossModel
      {
         return ConsortiaNewBossManager.instance.model;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc5_:String = null;
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(_data.templateId);
            if(!_loc4_)
            {
               clear();
               return;
            }
            _buyBtn.visible = true;
            initEvent();
            _loc5_ = IconFactory.getCommonIconPath(_loc4_.Icons);
            _goods.icon.icon = _loc5_;
            _goods.icon.tipStyle = "yishi.view.tips.ConsortiaNewBossBufferTip";
            _loc3_ = {};
            _loc3_.bufferName = _loc4_.TemplateName;
            _loc3_.bufferDesc = _loc4_.Description;
            _loc2_ = getBufferTime();
            _loc3_.leftTime = _loc2_;
            _loc3_.needCount = false;
            _goods.icon.tipData = _loc3_;
            _value.text = _data.count.toString();
            _name.text = _loc4_.TemplateName;
         }
         else
         {
            clear();
         }
      }
      
      private function getBufferTime() : int
      {
         return ConfigInfoManager.instance.getConsortiaNewbossBuffTime();
      }
      
      private function clear() : void
      {
         _data = null;
         _goods.data = null;
         _name.text = "";
         _value.text = "";
         _buyBtn.visible = false;
         removeEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _buyBtn = null;
         _name = null;
         _value = null;
         _goods = null;
         _currentImg = null;
         _leftTimeTxt = null;
         _currentTxt = null;
      }
   }
}

