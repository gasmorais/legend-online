package bottle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.item.BottleItemInfoMsg;
   import com.road.yishi.proto.item.BottlePackage;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.bottle.BottleUserInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.tips.BaseTip;
   
   public class BottleBoxViewTips extends BaseTip
   {
      
      private var _titleText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _line:Bitmap;
      
      private var _gongxi:FilterFrameText;
      
      private var _vipImge:Bitmap;
      
      private var _userName:FilterFrameText;
      
      private var _getReward:FilterFrameText;
      
      public function BottleBoxViewTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _titleText = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBoxViewTips.titleText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBoxViewTips.nameText");
         _line = ComponentFactory.Instance.creatBitmap("asset.bottle.line");
         _gongxi = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBoxViewTips.gongxi");
         _vipImge = ComponentFactory.Instance.creatBitmap("asset.bottle.vipImage");
         _userName = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBoxViewTips.userName");
         _getReward = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBoxViewTips.getReward");
         addChild(_titleText);
      }
      
      private function clear() : void
      {
         if(_nameText && _nameText.parent)
         {
            _nameText.parent.removeChild(_nameText);
         }
         if(_line && _line.parent)
         {
            _line.parent.removeChild(_line);
         }
         if(_gongxi && _gongxi.parent)
         {
            _gongxi.parent.removeChild(_gongxi);
         }
         if(_vipImge && _vipImge.parent)
         {
            _vipImge.parent.removeChild(_vipImge);
         }
         if(_userName && _userName.parent)
         {
            _userName.parent.removeChild(_userName);
         }
         if(_getReward && _getReward.parent)
         {
            _getReward.parent.removeChild(_getReward);
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:Object = null;
         var _loc2_:BottleUserInfo = null;
         var _loc4_:BottlePackage = null;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc1_:String = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:int = 0;
         if(tipData)
         {
            clear();
            _bg.width = 330;
            _loc8_ = tipData as Object;
            if(_loc8_.hasOwnProperty("packageData"))
            {
               _loc4_ = _loc8_.packageData;
            }
            if(_loc8_.hasOwnProperty("userInfo"))
            {
               _loc2_ = _loc8_.userInfo;
            }
            _titleText.text = LanguageMgr.GetTranslation("bottle.BottleBoxViewTips.title");
            if(_loc4_)
            {
               _loc3_ = _loc4_.item;
            }
            if(_loc3_)
            {
               addChild(_nameText);
               _loc7_ = int(_loc3_.length);
               _loc1_ = "";
               _loc5_ = new GoodsInfo();
               _loc6_ = 0;
               while(_loc6_ < _loc7_)
               {
                  _loc5_.templateId = (_loc3_[_loc6_] as BottleItemInfoMsg).tempId;
                  if(_loc3_[_loc6_] && _loc3_[_loc6_] as BottleItemInfoMsg && _loc5_.templateInfo)
                  {
                     _loc1_ += _loc5_.templateInfo.TemplateName + "*" + (_loc3_[_loc6_] as BottleItemInfoMsg).count + ",";
                  }
                  _loc6_++;
               }
               _nameText.text = _loc1_.substring(0,_loc1_.lastIndexOf(","));
               _bg.height = _nameText.y + _nameText.height + 6;
               if(_loc2_ != null)
               {
                  addChild(_line);
                  addChild(_gongxi);
                  addChild(_userName);
                  addChild(_getReward);
                  _line.y = _nameText.y + _nameText.height;
                  _line.x = 20;
                  _bg.height = _line.y + 27;
                  _gongxi.text = LanguageMgr.GetTranslation("bottle.BottleBoxViewTips.gongxi");
                  _userName.text = _loc2_.userName;
                  _getReward.text = LanguageMgr.GetTranslation("bottle.BottleBoxViewTips.getreward");
                  _gongxi.x = 10;
                  if(_loc2_.isVip)
                  {
                     addChild(_vipImge);
                     _vipImge.x = _gongxi.x + _gongxi.width;
                     _userName.x = _vipImge.x + _vipImge.width;
                     _getReward.x = _userName.x + _userName.width;
                     _gongxi.y = _vipImge.y = _userName.y = _userName.y = _getReward.y = _line.y + 5;
                  }
                  else
                  {
                     if(_vipImge && _vipImge.parent)
                     {
                        _vipImge.parent.removeChild(_vipImge);
                     }
                     _userName.x = _gongxi.x + _gongxi.width;
                     _getReward.x = _userName.x + _userName.width;
                     _gongxi.y = _userName.y = _userName.y = _getReward.y = _line.y + 5;
                  }
               }
            }
            else
            {
               addChild(_nameText);
               _nameText.text = LanguageMgr.GetTranslation("bottle.BottleBoxViewTips.nameText");
               _bg.height = 35;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_gongxi);
         _gongxi = null;
         ObjectUtils.disposeObject(_vipImge);
         _vipImge = null;
         ObjectUtils.disposeObject(_userName);
         _userName = null;
         ObjectUtils.disposeObject(_getReward);
         _getReward = null;
      }
   }
}

