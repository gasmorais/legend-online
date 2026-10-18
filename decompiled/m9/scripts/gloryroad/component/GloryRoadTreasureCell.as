package gloryroad.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadRewarCellInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.PageListBaseCell;
   
   public class GloryRoadTreasureCell extends PageListBaseCell
   {
      
      private var _boxImage:Image;
      
      private var _passTxt:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:IconButton;
      
      private var _token:TokenAmountItem;
      
      private var _bgLine:ScaleBitmapImage;
      
      public function GloryRoadTreasureCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _boxImage = ComponentFactory.Instance.creatComponentByStylename("GloryRoadTreasureCell.boxImage");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("gloryroad.Item.treasure");
         _passTxt = ComponentFactory.Instance.creatComponentByStylename("gloryroad.treasureCellPassTxt");
         _descText = ComponentFactory.Instance.creatComponentByStylename("gloryroad.descText");
         _btn = ComponentFactory.Instance.creatComponentByStylename("gloryroad.treaseCellBtn");
         _bgLine = ComponentFactory.Instance.creatComponentByStylename("gloryroad.treasureCutLine");
         _token = ComponentFactory.Instance.creatComponentByStylename("gloryroad.treaseCellToken");
         _token.firstText = GloryroadManager.instance.model.getConfig().openBoxPoint.toString();
         addChild(_boxImage);
         addChild(_hBox);
         addChild(_passTxt);
         addChild(_descText);
         addChild(_btn);
         addChild(_token);
         addChild(_bgLine);
         _descText.htmlText = LanguageMgr.GetTranslation("gloryroad.descText.text");
         _boxImage.tipData = LanguageMgr.GetTranslation("GloryRoadTreasureCell.boxImage.tipData");
      }
      
      private function initEvent() : void
      {
         if(_btn)
         {
            _btn.addEventListener("click",__clickHanlder);
         }
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHanlder);
      }
      
      protected function __clickHanlder(param1:MouseEvent) : void
      {
         var _loc3_:int = int(GloryroadManager.instance.model.getConfig().openBoxPoint);
         var _loc2_:String = LanguageMgr.GetTranslation("GloryRoadTreasureCell.clickHanlder.alert",_loc3_);
         LogicUtils.alert(_loc2_,"SIMPLE_ALERT",suerHandler);
      }
      
      private function suerHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:GloryRoadRewarCellInfo = super.data as GloryRoadRewarCellInfo;
         if(!LogicUtils.judgePointEnoughToShowPay(_loc3_.onePay,false))
         {
            return;
         }
         GloryroadManager.instance.openBox(1,_loc3_.grade);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc7_:Array = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc9_:GloryRoadRewarCellInfo;
         super.data = _loc9_ = param1 as GloryRoadRewarCellInfo;
         _passTxt.text = LanguageMgr.GetTranslation("GloryRoadTreasureCell.setData.grade",_loc9_.grade);
         ObjectUtils.disposeAllChildren(_hBox);
         _token.setSecondText(_loc9_.haveOpenAmount + "/10");
         _btn.enable = _loc9_.isCanOpen;
         var _loc3_:Array = _loc9_.items;
         _loc6_ = 0;
         _loc5_ = int(_loc3_.length);
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc3_[_loc6_].split(",");
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_[0]);
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc7_[0];
            _loc8_.count = _loc7_[1];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("gloryroad.rewardItem");
            _loc2_.data = _loc8_;
            _hBox.addChild(_loc2_);
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_passTxt);
         _passTxt = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_boxImage);
         _boxImage = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_token);
         _token = null;
         ObjectUtils.disposeObject(_bgLine);
         _bgLine = null;
         super.dispose();
      }
   }
}

