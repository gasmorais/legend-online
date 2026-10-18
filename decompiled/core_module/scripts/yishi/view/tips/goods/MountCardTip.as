package yishi.view.tips.goods
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.WildSoulCollection;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class MountCardTip extends BaseTip
   {
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _totalBox:VBox;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _type:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _send:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _additionVbox:VBox;
      
      private var _additionItem1:AttributeTipsItem;
      
      private var _additionItem2:AttributeTipsItem;
      
      private var _additionItem3:AttributeTipsItem;
      
      private var _additionItem4:AttributeTipsItem;
      
      private var _additionItem5:AttributeTipsItem;
      
      private var _additionItem6:AttributeTipsItem;
      
      private var _scoreItem:AttributeTipsItem;
      
      private var _describe:FilterFrameText;
      
      private var _vailityTxt:FilterFrameText;
      
      private var _noRefreshTxt:FilterFrameText;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      private var _splitLine03:Bitmap;
      
      private var _splitLine04:Bitmap;
      
      private var _areaType:ScaleFrameImage;
      
      private var _isActivate:FilterFrameText;
      
      private var isDie:Boolean = false;
      
      private var _showArea:MountAvaterContainer;
      
      private var _mountMovieClip:MovieClip;
      
      public function MountCardTip()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_container);
         if(_yellowBg)
         {
            ObjectUtils.disposeObject(_yellowBg);
         }
         _yellowBg = null;
         if(_purpleBg)
         {
            ObjectUtils.disposeObject(_purpleBg);
         }
         _purpleBg = null;
         if(_blueBg)
         {
            ObjectUtils.disposeObject(_blueBg);
         }
         _blueBg = null;
         if(_greenBg)
         {
            ObjectUtils.disposeObject(_greenBg);
         }
         _greenBg = null;
         if(_whiteBg)
         {
            ObjectUtils.disposeObject(_whiteBg);
         }
         _whiteBg = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
         if(_type)
         {
            _type.dispose();
         }
         _type = null;
         if(_grade)
         {
            _grade.dispose();
         }
         _grade = null;
         if(_send)
         {
            _send.dispose();
         }
         _send = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(_additionItem1)
         {
            ObjectUtils.disposeObject(_additionItem1);
         }
         _additionItem1 = null;
         if(_additionItem2)
         {
            ObjectUtils.disposeObject(_additionItem2);
         }
         _additionItem2 = null;
         if(_additionItem3)
         {
            ObjectUtils.disposeObject(_additionItem3);
         }
         _additionItem3 = null;
         if(_additionItem4)
         {
            ObjectUtils.disposeObject(_additionItem4);
         }
         _additionItem4 = null;
         if(_additionItem5)
         {
            ObjectUtils.disposeObject(_additionItem5);
         }
         _additionItem5 = null;
         if(_additionItem6)
         {
            ObjectUtils.disposeObject(_additionItem6);
         }
         _additionItem6 = null;
         if(_additionVbox)
         {
            ObjectUtils.disposeObject(_additionVbox);
         }
         _additionVbox = null;
         if(_scoreItem)
         {
            ObjectUtils.disposeObject(_scoreItem);
         }
         _scoreItem = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_vailityTxt)
         {
            _vailityTxt.dispose();
         }
         _vailityTxt = null;
         if(_isActivate)
         {
            _isActivate.dispose();
         }
         _isActivate = null;
         if(_noRefreshTxt)
         {
            ObjectUtils.disposeObject(_noRefreshTxt);
         }
         _noRefreshTxt = null;
         if(_splitLine01)
         {
            ObjectUtils.disposeObject(_splitLine01);
         }
         _splitLine01 = null;
         if(_splitLine02)
         {
            ObjectUtils.disposeObject(_splitLine02);
         }
         _splitLine02 = null;
         if(_splitLine03)
         {
            ObjectUtils.disposeObject(_splitLine03);
         }
         _splitLine03 = null;
         if(_splitLine04)
         {
            ObjectUtils.disposeObject(_splitLine04);
         }
         _splitLine04 = null;
         if(_areaType)
         {
            ObjectUtils.disposeObject(_areaType);
         }
         _areaType = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      override protected function init() : void
      {
         super.init();
         _container = new Sprite();
         _additionVbox = new VBox();
         _bg.width = 322;
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTypeTxt");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText1");
         _bindText.x = 200;
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _scoreItem = new AttributeTipsItem();
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.MountTipTxt");
         _vailityTxt = ComponentFactory.Instance.creatComponentByStylename("tips.MountTipTxt");
         _noRefreshTxt = ComponentFactory.Instance.creatComponentByStylename("tips.MountTipTxt");
         _isActivate = ComponentFactory.Instance.creatComponentByStylename("tips.MountTipTxt.IsActivateTxt");
         _areaType = ComponentFactory.Instance.creatComponentByStylename("mounts.areaType");
         _additionItem1 = new AttributeTipsItem();
         _additionItem2 = new AttributeTipsItem();
         _additionItem3 = new AttributeTipsItem();
         _additionItem4 = new AttributeTipsItem();
         _additionItem5 = new AttributeTipsItem();
         _additionItem6 = new AttributeTipsItem();
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.width = 210;
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02.width = 210;
         _splitLine03 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine03.width = 210;
         _splitLine04 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine04.width = 210;
         _describe.setFrame(2);
         _vailityTxt.setFrame(3);
         _noRefreshTxt.setFrame(3);
         _showArea = new MountAvaterContainer();
         addChild(_yellowBg);
         _yellowBg.width = 200;
         addChild(_purpleBg);
         _purpleBg.width = 200;
         addChild(_blueBg);
         _blueBg.width = 200;
         addChild(_greenBg);
         _greenBg.width = 200;
         addChild(_whiteBg);
         _whiteBg.width = 200;
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         addChild(_title);
         addChild(_type);
         addChild(_areaType);
         _areaType.y = 10;
         _title.y = 18;
         _title.width = 220;
         _title.x = 70;
         _type.y = 10;
         _totalBox.x = 10;
         _totalBox.y = 55;
         _totalBox.spacing = 4;
         _grade.x = 4;
         _grade.width = 125;
         _price.x = 0;
         _describe.width = 290;
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc8_:MountTemplate = null;
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc1_:String = null;
         if(tipData)
         {
            clean();
            _loc7_ = tipData as GoodsInfo;
            _title.setFrame(_loc7_.templateInfo.Profile);
            _title.text = _loc7_.templateInfo.TemplateName;
            _type.text = getGoodsTypeName(_loc7_.templateInfo);
            _itemIcon.icon = IconFactory.getGoodsIconByTID(_loc7_.templateInfo.TemplateId);
            if(_loc7_.isBinds)
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               _bindText.setFrame(1);
            }
            else
            {
               _bindText.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               _bindText.setFrame(2);
            }
            _loc8_ = TempleteManager.instance.mountTemplateDic[_loc7_.templateInfo.Property1];
            _loc2_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips01").split("|");
            if(_loc8_)
            {
               _loc4_ = [_loc8_.Power,_loc8_.Intellect,_loc8_.Physique,_loc8_.Agility,_loc8_.ExpandLevel,_loc8_.Speed];
               _loc5_ = "";
               _loc3_ = 0;
               while(_loc3_ < _loc4_.length)
               {
                  if(_loc4_[_loc3_] != 0 && _loc3_ < _loc2_.length)
                  {
                     _loc5_ += StringHelper.format(_loc2_[_loc3_],_loc4_[_loc3_]) + "<br/>";
                     this["_additionItem" + (_loc3_ + 1)].setData(StringHelper.format(_loc2_[_loc3_],_loc4_[_loc3_]),1);
                     _additionVbox.addChild(this["_additionItem" + (_loc3_ + 1)]);
                  }
                  _loc3_++;
               }
            }
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
            _loc6_ = MountAvatarPathHelper.getUrl(_loc8_.AvatarPath);
            LoaderManagerII.instance.load(_loc6_,2,4,__onLoaded);
            _scoreItem.setData(LanguageMgr.GetTranslation("mountTip.soulscore",_loc8_.SoulScore),4);
            _additionVbox.addChild(_scoreItem);
            _describe.text = _loc7_.templateInfo.Description;
            _describe.height = _describe.textHeight + 5;
            _areaType.setFrame(_loc8_.Area + 1);
            if(_loc7_.templateInfo.Property2 <= 0)
            {
               _loc5_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.forever");
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips02",_loc7_.templateInfo.Property2);
            }
            _vailityTxt.htmlText = _loc5_;
            _vailityTxt.height = _vailityTxt.textHeight + 5;
            _noRefreshTxt.htmlText = LanguageMgr.GetTranslation("mountTip.MountCardTip.noRefreshTxt");
            _noRefreshTxt.height = _noRefreshTxt.textHeight + 5;
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.price",_loc7_.templateInfo.SellGold * (1 + _loc7_.strengthenGrade * 2));
            _price.text = _loc7_.templateInfo.SellGold == 0 ? "" : _loc1_;
            if(_loc7_.templateInfo.NeedGrades > 1)
            {
               _grade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade02",_loc7_.templateInfo.NeedGrades);
               if(!GoodsCheck.isGradeFix(ArmyManager.instance.thane,_loc7_.templateInfo,false))
               {
                  _grade.textColor = 16711680;
               }
               _container.addChild(_grade);
               _grade.visible = true;
            }
            else
            {
               _grade.visible = false;
            }
            _totalBox.addChild(_container);
            if(_loc7_.id != 0)
            {
               _container.addChild(_bindText);
               _bindText.visible = true;
               _totalBox.addChild(_splitLine01);
               if(_additionVbox.numChildren > 0)
               {
                  _totalBox.addChild(_additionVbox);
                  _totalBox.addChild(_splitLine02);
               }
               _totalBox.addChild(_showArea);
               _totalBox.addChild(_splitLine03);
               _totalBox.addChild(_describe);
               if(_loc7_.templateInfo.Refresh == -1)
               {
                  _totalBox.addChild(_noRefreshTxt);
               }
               _totalBox.addChild(_vailityTxt);
               _totalBox.addChild(_splitLine04);
               if(_loc7_.templateId != 208002 && _loc7_.templateId != 208003)
               {
                  _send.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
                  _totalBox.addChild(_send);
               }
               if(_loc7_.templateInfo.SellGold > 0)
               {
                  _totalBox.addChild(_price);
               }
            }
            else
            {
               _bindText.visible = false;
               _totalBox.addChild(_splitLine01);
               if(_additionVbox.numChildren > 0)
               {
                  _totalBox.addChild(_additionVbox);
                  _totalBox.addChild(_splitLine02);
               }
               _totalBox.addChild(_showArea);
               _totalBox.addChild(_splitLine03);
               _totalBox.addChild(_describe);
               if(_loc7_.templateInfo.Refresh == -1)
               {
                  _totalBox.addChild(_noRefreshTxt);
               }
               _totalBox.addChild(_vailityTxt);
               _totalBox.draw();
            }
            if(wildSoulCollection.isLightTemplate(_loc8_.TemplateId))
            {
               _isActivate.text = LanguageMgr.GetTranslation("mountTip.IsActivateTxt");
               addChild(_isActivate);
               _isActivate.y = _totalBox.y + _vailityTxt.y;
            }
            _bg.height = _totalBox.y + _totalBox.height + 10;
            showProfileBg(_loc7_.templateInfo.Profile);
            _price.x = 75;
            _profileImg.setFrame(_loc7_.templateInfo.Profile);
            _yellowBg.width = _bg.width;
            _purpleBg.width = _bg.width;
            _blueBg.width = _bg.width;
            _greenBg.width = _bg.width;
            _whiteBg.width = _bg.width;
         }
         _areaType.x = _bg.width - 30;
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:BitmapData = null;
         var _loc3_:Rectangle = null;
         if(param2 != null && _showArea != null)
         {
            if(_mountMovieClip)
            {
               _mountMovieClip.stop();
               _mountMovieClip.parent && _mountMovieClip.parent.removeChild(_mountMovieClip);
            }
            _mountMovieClip = param2 as MovieClip;
            if(_mountMovieClip)
            {
               _mountMovieClip.gotoAndStop(1);
               _loc4_ = new BitmapData(500,500,true,0);
               _loc4_.draw(_mountMovieClip);
               _loc3_ = _loc4_.getColorBoundsRect(4278190080,0,false);
               _showArea.addChild(_mountMovieClip);
               _mountMovieClip.x = int((210 - _loc3_.width) / 2) - _loc3_.x;
               _mountMovieClip.y = int((210 - _loc3_.height) / 2) - _loc3_.y;
               _mountMovieClip.gotoAndPlay(1);
               _loc4_.dispose();
               _loc4_ = null;
            }
            _totalBox.refreshChildPos();
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         _yellowBg.y = 0;
         _purpleBg.y = 0;
         _blueBg.y = 0;
         _greenBg.y = 0;
         _whiteBg.y = 0;
         _bg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               _whiteBg.height = _bg.height;
               break;
            case 1:
               _greenBg.visible = true;
               _greenBg.height = _bg.height;
               break;
            case 2:
               _blueBg.visible = true;
               _blueBg.height = _bg.height;
               break;
            case 3:
               _purpleBg.visible = true;
               _purpleBg.height = _bg.height;
               break;
            case 4:
               _yellowBg.visible = true;
               _yellowBg.height = _bg.height;
         }
      }
      
      private function clean() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         _loc1_ = 1;
         while(_loc1_ < 7)
         {
            if(this["_additionItem" + _loc1_].parent)
            {
               this["_additionItem" + _loc1_].parent.removeChild(this["_additionItem" + _loc1_]);
            }
            if(_loc1_ < 4)
            {
               if(this["_splitLine0" + _loc1_].parent)
               {
                  this["_splitLine0" + _loc1_].parent.removeChild(this["_splitLine0" + _loc1_]);
               }
            }
            _loc1_++;
         }
         while(_totalBox.numChildren > 0)
         {
            _loc2_ = _totalBox.getChildAt(0);
            _totalBox.removeChild(_loc2_);
         }
         if(_isActivate && _isActivate.parent)
         {
            _isActivate.parent.removeChild(_isActivate);
         }
      }
      
      private function getGoodsTypeName(param1:GoodsTemplateInfo) : String
      {
         switch(param1.SonType - 210)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.SONTYPE_TASK");
            case 2:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.PropTips.COMPOSE_MATERIAL");
            default:
               return "";
         }
      }
      
      private function get wildSoulCollection() : WildSoulCollection
      {
         return MountsManager.instance.avatarList;
      }
   }
}

import com.pickgliss.instance.IManualSize;
import flash.display.Sprite;
import flash.geom.Rectangle;

class MountAvaterContainer extends Sprite implements IManualSize
{
   
   public function MountAvaterContainer()
   {
      super();
   }
   
   public function get viewRectangle() : Rectangle
   {
      return new Rectangle(0,0,210,210);
   }
}
