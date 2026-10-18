package gloryroad.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import managers.GloryroadManager;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.PageListBaseCell;
   
   public class GloryRoadScoreCell extends PageListBaseCell
   {
      
      private var _top:Shape;
      
      private var _hBox:HBox;
      
      private var _bgLine:ScaleBitmapImage;
      
      private var _txt:FilterFrameText;
      
      private var _grids:Vector.<BaseItemView>;
      
      private var _btn:IconButton;
      
      private var _haveAccpetedBmp:Bitmap;
      
      public function GloryRoadScoreCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _top = new Shape();
         _top.graphics.beginFill(16777215);
         _top.graphics.drawRect(0,0,10,10);
         _top.graphics.endFill();
         _top.visible = false;
         _hBox = ComponentFactory.Instance.creatComponentByStylename("gloryroad.Item.Contain");
         _bgLine = ComponentFactory.Instance.creatComponentByStylename("gloryroad.rewardCutLine");
         _txt = ComponentFactory.Instance.creatComponentByStylename("gloryroad.scroeCellTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("gloryroad.scoreAcceptBtn");
         _haveAccpetedBmp = ComponentFactory.Instance.creatBitmap("asset.gloryroad.haveAccepted");
         addChild(_top);
         addChild(_hBox);
         addChild(_bgLine);
         addChild(_txt);
         addChild(_btn);
         addChild(_haveAccpetedBmp);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         GloryroadManager.instance.getScoreReward(UpgradeTemplateInfo(data).Grades);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc8_:Array = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc9_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc2_:int = 0;
         super.data = param1;
         ObjectUtils.disposeAllChildren(_hBox);
         var _loc10_:UpgradeTemplateInfo = param1 as UpgradeTemplateInfo;
         _txt.text = _loc10_.Data.toString();
         var _loc4_:Array = _loc10_.TemplateName.split("|");
         _loc7_ = 0;
         _loc6_ = int(_loc4_.length);
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc4_[_loc7_].split(",");
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc8_[0]);
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = _loc8_[0];
            _loc9_.count = _loc8_[1];
            _loc3_ = ComponentFactory.Instance.creatCustomObject("gloryroad.rewardItem");
            _loc3_.data = _loc9_;
            _hBox.addChild(_loc3_);
            _loc7_++;
         }
         if(_loc10_.ActiveObject == -1)
         {
            _btn.visible = false;
            _haveAccpetedBmp.visible = true;
         }
         else
         {
            _btn.visible = true;
            _haveAccpetedBmp.visible = false;
            _loc2_ = int(GloryroadManager.instance.model.score);
            _btn.enable = _loc2_ >= _loc10_.Data;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_top);
         _top = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_bgLine);
         _bgLine = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         LogicUtils.disposeDisplayCollection(_grids);
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_haveAccpetedBmp);
         _haveAccpetedBmp = null;
         super.dispose();
      }
   }
}

