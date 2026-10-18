package vip
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class VipBoxItem extends Component
   {
      
      private var _temId:int;
      
      private var _boxItem:BaseItemView;
      
      private var _selectBg:Bitmap;
      
      private var _index:int;
      
      private var _countTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _flickerEffct:MovieClip;
      
      private var _nullItemBg:Bitmap;
      
      public function VipBoxItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _boxItem = ComponentFactory.Instance.creatCustomObject("vip.vipBoxItem");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.armyII.vipBoxItemSelect");
         _nullItemBg = ComponentFactory.Instance.creatBitmap("asset.armyII.vipBoxNullItemBg");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("armyII.goodsFlickerEffctMC");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.VipBoxItemCountTxt");
         addChild(_boxItem);
         addChild(_countTxt);
         addChild(_selectBg);
         addChild(_nullItemBg);
         _nullItemBg.visible = false;
         addChild(_flickerEffct);
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
         _selectBg.visible = false;
      }
      
      public function set Index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get Index() : int
      {
         return _index;
      }
      
      public function set count(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 >= 1000000)
         {
            _loc2_ = (param1 / 1000000).toFixed(1) + LanguageMgr.GetTranslation("public.Million");
         }
         else if(param1 > 999000 && param1 < 1000000)
         {
            _loc2_ = "1.0" + LanguageMgr.GetTranslation("public.Million");
         }
         else if(param1 >= 10000 && param1 <= 999000)
         {
            _loc2_ = Math.round(param1 / 1000) + LanguageMgr.GetTranslation("public.Thousands");
         }
         else
         {
            _loc2_ = param1 + "";
         }
         _countTxt.text = _loc2_;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:GoodsInfo = null;
         _temId = param1;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_temId);
         if(_loc3_)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _temId;
            _boxItem.data = _loc2_;
         }
         else
         {
            _boxItem.data = null;
            _nullItemBg.visible = true;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selected)
         {
            _selectBg.alpha = 1;
            _selectBg.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectBg.visible = false;
         }
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
         _selectBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         TweenLite.to(_selectBg,param1,{"alpha":0});
      }
      
      public function flicker() : void
      {
         _selectBg.visible = false;
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
         StageReferance.stage.addEventListener("enterFrame",_stageFrame);
      }
      
      private function _stageFrame(param1:Event) : void
      {
         if(_flickerEffct.currentFrame == _flickerEffct.totalFrames)
         {
            _flickerEffct.visible = false;
            _flickerEffct.gotoAndStop(1);
            StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
            model.dispatchEvent(new VIPEvent("vipeffctcomplete"));
            _boxItem.data = null;
            _nullItemBg.visible = true;
         }
      }
      
      private function get model() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boxItem);
         ObjectUtils.disposeObject(_selectBg);
         ObjectUtils.disposeObject(_countTxt);
         ObjectUtils.disposeObject(_flickerEffct);
         ObjectUtils.disposeObject(_nullItemBg);
         _countTxt = null;
         _nullItemBg = null;
         _flickerEffct = null;
         _boxItem = null;
         _selectBg = null;
         super.dispose();
      }
   }
}

