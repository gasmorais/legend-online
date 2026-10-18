package fundVein
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.fundVein.RewardItemInfo;
   
   public class FundVeinDiamondCell extends Component
   {
      
      private var _numTxt:FilterFrameText;
      
      private var _diamondImg:ScaleFrameImage;
      
      private var _endXPoint:int;
      
      private var _space:int = 10;
      
      public function FundVeinDiamondCell(param1:int, param2:Boolean = false, param3:int = 10, param4:Boolean = false)
      {
         super();
         this._endXPoint = param1;
         this._space = param3;
         initView(param2,param4);
      }
      
      private function initView(param1:Boolean, param2:Boolean = false) : void
      {
         if(param2)
         {
            _numTxt = ComponentFactory.Instance.creatComponentByStylename("fund.itemnumTxt_3");
         }
         else
         {
            _numTxt = ComponentFactory.Instance.creatComponentByStylename("fund.itemnumTxt");
         }
         addChild(_numTxt);
         _diamondImg = ComponentFactory.Instance.creatComponentByStylename("fund.diamondImg");
         if(param2)
         {
            _diamondImg.y += 3;
         }
         addChild(_diamondImg);
         update(0);
      }
      
      public function update(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:String = param2 ? "mainBar.WorldBossBuyBuffBar.giftToken" : "mainBar.WorldBossBuyBuffBar.point";
         _diamondImg.tipData = LanguageMgr.GetTranslation(_loc3_);
         _diamondImg.setFrame(param2 ? 2 : 1);
         _numTxt.text = (param1 || 0).toString();
         _diamondImg.x = _numTxt.width + _space;
         this.x = _endXPoint - _numTxt.width - _space - _diamondImg.width;
      }
      
      public function updateView(param1:RewardItemInfo) : void
      {
         if(param1)
         {
            this.update(param1.count,param1.tempId == -500);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeAllGrandson(_diamondImg);
         _diamondImg = null;
         super.dispose();
         ObjectUtils.disposeSelf(this);
      }
   }
}

