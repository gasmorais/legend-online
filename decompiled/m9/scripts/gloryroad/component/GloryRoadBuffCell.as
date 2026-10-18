package gloryroad.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import managers.GloryroadManager;
   import yishi.datas.templates.GloryRoadBufferTemplateInfo;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.PageListBaseCell;
   
   public class GloryRoadBuffCell extends PageListBaseCell
   {
      
      private var _lightBg:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _starToken:TokenAmountItem;
      
      private var _attTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _buffId:int;
      
      public function GloryRoadBuffCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _lightBg = new Bitmap();
         _lightBg.visible = false;
         _bg = new Bitmap();
         _bg.x = 3;
         _bg.y = 6;
         _starToken = ComponentFactory.Instance.creatComponentByStylename("gloryroad.buffStarToken");
         _attTxt = ComponentFactory.Instance.creatComponentByStylename("gloryroad.buffAttTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("gloryroad.buffBuyBtn");
         addChild(_lightBg);
         addChildAt(_bg,0);
         addChild(_starToken);
         addChild(_attTxt);
         addChild(_btn);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvnet() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__btnClickHandler);
         }
      }
      
      protected function __btnClickHandler(param1:MouseEvent) : void
      {
         GloryroadManager.instance.buyBuff(_buffId);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:GloryRoadBufferTemplateInfo = param1 as GloryRoadBufferTemplateInfo;
         if(_loc2_)
         {
            _buffId = _loc2_.TemplateId;
            _lightBg.bitmapData = ClassUtils.CreatInstance("asset.gloryroad.difficultyGridSelect" + _loc2_.index);
            _bg.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.gloryroad.buffBg" + _loc2_.index);
            _attTxt.y = 122 + (90 - _attTxt.textHeight) * 0.5;
            _starToken.setFirstText(_loc2_.Price.toString());
            _loc3_ = _loc2_.Desc;
            if(_loc3_.indexOf("Percent") != -1)
            {
               _loc3_ = _loc3_.replace("{Percent}",_loc2_.Percent);
            }
            if(_loc3_.indexOf("Value") != -1)
            {
               _loc3_ = _loc3_.replace("{Value}",_loc2_.Value);
            }
            _attTxt.text = _loc3_;
            _btn.enable = !_loc2_.isPurchased;
         }
      }
      
      override public function mouseOverHandler(param1:Event) : void
      {
         _lightBg.visible = true;
      }
      
      override public function mouseOutHandler(param1:Event) : void
      {
         _lightBg.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvnet();
         if(_lightBg)
         {
            ObjectUtils.disposeObject(_lightBg);
         }
         _lightBg = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_starToken)
         {
            ObjectUtils.disposeObject(_starToken);
         }
         _starToken = null;
         if(_attTxt)
         {
            ObjectUtils.disposeObject(_attTxt);
         }
         _attTxt = null;
         if(_btn)
         {
            ObjectUtils.disposeObject(_btn);
         }
         _btn = null;
         super.dispose();
      }
   }
}

