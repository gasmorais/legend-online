package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class FundItem extends Component
   {
      
      private var _numTxt:FilterFrameText;
      
      private var _diamondImg:ScaleFrameImage;
      
      private var _itemIcon:BaseItemView;
      
      private var _deedImg:ScaleBitmapImage;
      
      private var _data:*;
      
      private var _goodsTempInfo:GoodsTemplateInfo;
      
      private var _goodsInfo:GoodsInfo;
      
      public function FundItem()
      {
         super();
      }
      
      public function show(param1:*) : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         _data = param1;
         if(_data == null)
         {
            return;
         }
         if(_data.type == 0)
         {
            _numTxt = ComponentFactory.Instance.creatComponentByStylename("fund.itemnumTxt");
            _numTxt.text = _data.num;
            if(_data.itemTempleteId != -400 && _data.itemTempleteId != -500)
            {
               if(_data.itemTempleteId == 2125044)
               {
                  _deedImg = ComponentFactory.Instance.creatComponentByStylename("fund.deedImg");
                  _deedImg.x = _numTxt.textWidth + 3;
                  _loc2_ = new GoodsInfo();
                  _loc2_.templateId = 2125044;
                  _deedImg.tipData = _loc2_;
                  addChild(_deedImg);
               }
               else
               {
                  _itemIcon = ComponentFactory.Instance.creatCustomObject("fund.DropItem");
                  _itemIcon.x = _numTxt.textWidth + 3;
                  _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.itemTempleteId);
                  _goodsInfo = new GoodsInfo();
                  _goodsInfo.templateId = _goodsTempInfo.TemplateId;
                  _goodsInfo.validDate = _data.ValidDate;
                  _itemIcon.data = _goodsInfo;
                  addChild(_itemIcon);
               }
            }
            else
            {
               _diamondImg = ComponentFactory.Instance.creatComponentByStylename("fund.diamondImg");
               _diamondImg.x = _numTxt.textWidth + 3;
               if(_data.itemTempleteId == -400)
               {
                  _diamondImg.setFrame(1);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
               }
               else if(_data.itemTempleteId == -500)
               {
                  _diamondImg.setFrame(2);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftToken");
                  addChild(_diamondImg);
               }
               addChild(_diamondImg);
            }
         }
         else if(_data.type == 1)
         {
            _numTxt = ComponentFactory.Instance.creatComponentByStylename("fund.itemnumTxt_2");
            _numTxt.text = _data.num;
            if(_data.itemTempleteId != -400 && _data.itemTempleteId != -500)
            {
               if(_data.itemTempleteId == 2125044)
               {
                  _deedImg = ComponentFactory.Instance.creatComponentByStylename("fund.deedImg");
                  _deedImg.x = _numTxt.textWidth + 3;
                  _loc3_ = new GoodsInfo();
                  _loc3_.templateId = 2125044;
                  _deedImg.tipData = _loc3_;
                  addChild(_deedImg);
               }
               else
               {
                  _itemIcon = ComponentFactory.Instance.creatCustomObject("fund.DropItem");
                  _itemIcon.x = _numTxt.width + 3;
                  _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.itemTempleteId);
                  _goodsInfo = new GoodsInfo();
                  _goodsInfo.templateId = _goodsTempInfo.TemplateId;
                  _goodsInfo.validDate = _data.ValidDate;
                  _itemIcon.data = _goodsInfo;
                  addChild(_itemIcon);
               }
            }
            else
            {
               _diamondImg = ComponentFactory.Instance.creatComponentByStylename("fund.diamondImg");
               _diamondImg.x = _numTxt.width + 3;
               if(_data.itemTempleteId == -400)
               {
                  _diamondImg.setFrame(1);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
               }
               else if(_data.itemTempleteId == -500)
               {
                  _diamondImg.setFrame(2);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftToken");
               }
               addChild(_diamondImg);
            }
         }
         else if(_data.type == 2)
         {
            _numTxt = ComponentFactory.Instance.creatComponentByStylename("fund.itemnumTxt_3");
            _numTxt.text = _data.num;
            if(_data.itemTempleteId != -400 && _data.itemTempleteId != -500)
            {
               _itemIcon = ComponentFactory.Instance.creatCustomObject("fund.DropItem");
               _itemIcon.x = _numTxt.textWidth + 3;
               _goodsTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.itemTempleteId);
               _goodsInfo = new GoodsInfo();
               _goodsInfo.templateId = _goodsTempInfo.TemplateId;
               _goodsInfo.validDate = _data.ValidDate;
               _itemIcon.data = _goodsInfo;
               addChild(_itemIcon);
            }
            else
            {
               _diamondImg = ComponentFactory.Instance.creatComponentByStylename("fund.diamondImg");
               _diamondImg.x = _numTxt.textWidth + 3;
               if(_data.itemTempleteId == -400)
               {
                  _diamondImg.setFrame(1);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
               }
               else if(_data.itemTempleteId == -500)
               {
                  _diamondImg.setFrame(2);
                  _diamondImg.tipData = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftToken");
               }
               addChild(_diamondImg);
            }
         }
         addChild(_numTxt);
      }
      
      override public function dispose() : void
      {
         if(_diamondImg)
         {
            ObjectUtils.disposeObject(_diamondImg);
            _diamondImg = null;
         }
         if(_numTxt)
         {
            ObjectUtils.disposeObject(_numTxt);
            _numTxt = null;
         }
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
            _itemIcon = null;
         }
         if(_deedImg)
         {
            ObjectUtils.disposeObject(_deedImg);
            _deedImg = null;
         }
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

