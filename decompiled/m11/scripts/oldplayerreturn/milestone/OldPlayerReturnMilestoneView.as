package oldplayerreturn.milestone
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.templates.OldPlayerReturnRewardTempInfo;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   
   public class OldPlayerReturnMilestoneView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _titleBack:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _numTxt:GradientText;
      
      private var _mc:MovieClip;
      
      private var _itemList:Array = [];
      
      private var pointArr:Array = [[227,68],[395,68],[567,68],[567,205],[395,205],[227,205],[45,205],[45,340],[227,340],[395,340],[567,340]];
      
      public function OldPlayerReturnMilestoneView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnTaskView.bg");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnMilestoneView.titleBack");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnMilestoneView.titleTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnMilestoneView.numTxt");
         _mc = ComponentFactory.Instance.creatCustomObject("OldPlayerReturnMilestoneView.mc");
         addChild(_bg);
         addChild(_titleBack);
         addChild(_titleTxt);
         addChild(_numTxt);
         addChild(_mc);
         _titleTxt.text = LanguageMgr.GetTranslation("OldPlayerReturnMilestoneView.titleTxt.text");
         _mc.gotoAndStop(1);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:OldPlayerReturnMilestoneItem = null;
         var _loc2_:int = 0;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 11)
         {
            _loc1_ = new OldPlayerReturnMilestoneItem();
            _loc1_.x = pointArr[_loc2_][0];
            _loc1_.y = pointArr[_loc2_][1];
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:OldPlayerReturnRewardTempInfo = null;
         var _loc1_:OldPlayerReturnMilestoneItem = null;
         var _loc3_:int = 0;
         _numTxt.text = model.milestoneScore.toString();
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc4_ = TempleteManager.instance.oldPlayerReturnRewardTempCate.getTempInfoByType(3,_loc3_ + 1);
            _loc1_ = _itemList[_loc3_];
            _loc1_.data = _loc4_;
            if(_loc4_.NeedCount <= model.milestoneScore)
            {
               _loc2_ = _loc3_ + 2;
            }
            _loc3_++;
         }
         _mc.gotoAndStop(_loc2_);
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         for each(var _loc1_:OldPlayerReturnMilestoneItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

