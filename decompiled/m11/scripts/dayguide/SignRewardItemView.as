package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.DayGuideManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SignRewardItemView extends Sprite
   {
      
      private var _titleImg:Bitmap;
      
      private var _signNumTxt:FilterFrameText;
      
      private var _getedImg:Bitmap;
      
      private var _dayIndex:int;
      
      private var _baseItemArr:Array;
      
      private var _itemSprite:Sprite;
      
      public function SignRewardItemView(param1:int)
      {
         super();
         _dayIndex = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.signRewardTitleImg");
         _signNumTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.DateItemViewTxt");
         _signNumTxt.text = _dayIndex.toString();
         _getedImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.CountedTxt");
         _itemSprite = new Sprite();
         addChild(_titleImg);
         addChild(_signNumTxt);
         _signNumTxt.setFrame(3);
         _baseItemArr = [];
         var _loc1_:Array = TempleteManager.instance.signDropTemplateCate.getTemplateByIndex(_dayIndex);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[_loc3_].TemplateId;
            _loc4_.count = _loc1_[_loc3_].Data;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("dayGuide.BaseItemView" + _loc3_);
            _loc2_.data = _loc4_;
            _loc2_.buttonMode = false;
            _itemSprite.addChild(_loc2_);
            _baseItemArr.push(_loc2_);
            _loc3_++;
         }
         addChild(_itemSprite);
         addChild(_getedImg);
         _getedImg.visible = false;
      }
      
      public function updateView() : void
      {
         _getedImg.visible = false;
         _itemSprite.filters = [];
         if(_dayIndex <= DayGuideManager.instance.daySignInfo.rewardTag)
         {
            _getedImg.visible = true;
            _itemSprite.filters = [UIFilter.getBlackFilter()];
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_signNumTxt);
         _signNumTxt = null;
         ObjectUtils.disposeObject(_getedImg);
         _getedImg = null;
         if(_baseItemArr != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _baseItemArr.length)
            {
               ObjectUtils.disposeObject(_baseItemArr[_loc1_]);
               _baseItemArr[_loc1_] = null;
               _loc1_++;
            }
            _baseItemArr = null;
         }
         ObjectUtils.disposeAllChildren(_itemSprite);
         _itemSprite = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

