package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.landmine.LandMineModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.LandMineManager;
   
   public class GameHallRewardTipView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _textList:Vector.<FilterFrameText>;
      
      private var _model:LandMineModel = LandMineManager.instance.model;
      
      public function GameHallRewardTipView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc3_:FilterFrameText = null;
         var _loc4_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallRewardTipView.vBox");
         _textList = new Vector.<FilterFrameText>();
         var _loc1_:int = int(_model.itemsIdArray.length);
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallRewardTipView.textFiled");
         _loc3_.text = LanguageMgr.GetTranslation("gamehall.GameHallRewardTipView.textFiledTitle");
         _vBox.addChild(_loc3_);
         _textList.push(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = int(_model.itemsIdArray[_loc4_]);
            _loc2_ = int(_model.itemsCountArray[_loc4_]);
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc5_;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallRewardTipView.textFiled");
            _loc3_.text = LanguageMgr.GetTranslation("gamehall.GameHallRewardTipView.textFiledTxt",_loc6_.templateInfo.TemplateName,_loc2_);
            _vBox.addChild(_loc3_);
            _textList.push(_loc3_);
            _loc4_++;
         }
         _bg.width = _vBox.width + 20;
         _bg.height = _vBox.height + 20;
         addChild(_bg);
         addChild(_vBox);
      }
      
      private function uninitView() : void
      {
         for each(var _loc1_:FilterFrameText in _textList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _textList = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         uninitView();
         super.dispose();
      }
   }
}

