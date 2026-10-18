package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.MountsManager;
   import managers.TheseussoulManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.pet.PetData;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   
   public class MySortView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Bitmap;
      
      private var _mySortImg:Bitmap;
      
      private var _consortiaSortImg:Bitmap;
      
      private var _sortTxtImg:Bitmap;
      
      private var _levelTxtImg:Bitmap;
      
      private var _expTxtImg:Bitmap;
      
      private var _buildTxtImg:Bitmap;
      
      private var _powtxtImg:Bitmap;
      
      private var _honourImg:Bitmap;
      
      private var _charmsImg:Bitmap;
      
      private var _theseImg:Bitmap;
      
      private var _soulImg:Bitmap;
      
      private var _txtBg1:ScaleLeftRightImage;
      
      private var _txtBg2:ScaleLeftRightImage;
      
      private var _txtBg3:ScaleLeftRightImage;
      
      private var _txtBg4:ScaleLeftRightImage;
      
      private var _para1:FilterFrameText;
      
      private var _para2:FilterFrameText;
      
      private var _para3:FilterFrameText;
      
      private var _petNameTxt:FilterFrameText;
      
      private var _petRankingTxt:FilterFrameText;
      
      private var _model:SortModel;
      
      public function MySortView(param1:SortModel)
      {
         super();
         _model = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mouseChildren = mouseEnabled = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.MySortBg");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.sort.MySortTopBg");
         _mySortImg = ComponentFactory.Instance.creatBitmap("asset.sort.MySortImg");
         _consortiaSortImg = ComponentFactory.Instance.creatBitmap("asset.sort.ConsortiaSortImg");
         _sortTxtImg = ComponentFactory.Instance.creatBitmap("asset.sort.SortTxtImg");
         _levelTxtImg = ComponentFactory.Instance.creatBitmap("asset.sort.LevelTxtImg");
         _expTxtImg = ComponentFactory.Instance.creatBitmap("asset.sort.ExperienceTxtImg");
         _buildTxtImg = ComponentFactory.Instance.creatBitmap("asset.sort.BuildTxtImg");
         _powtxtImg = ComponentFactory.Instance.creatBitmap("asset.sort.PowTxtImg");
         _honourImg = ComponentFactory.Instance.creatBitmap("asset.sort.honourTxtImg");
         _charmsImg = ComponentFactory.Instance.creatBitmap("asset.sort.CharmsTxtImg");
         _soulImg = ComponentFactory.Instance.creatBitmap("asset.sort.SoulScoreTxtImg");
         _theseImg = ComponentFactory.Instance.creatBitmap("asset.sort.jiaSelectedImg");
         _txtBg1 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg1");
         _txtBg2 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg2");
         _txtBg3 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg3");
         _txtBg4 = ComponentFactory.Instance.creatComponentByStylename("sort.textBg3");
         _para1 = ComponentFactory.Instance.creatComponentByStylename("sort.MySortTextStyle1");
         _para2 = ComponentFactory.Instance.creatComponentByStylename("sort.MySortTextStyle1");
         _para3 = ComponentFactory.Instance.creatComponentByStylename("sort.MySortTextStyle2");
         _petNameTxt = ComponentFactory.Instance.creatComponentByStylename("mysort.PetNameTxt");
         _petRankingTxt = ComponentFactory.Instance.creatComponentByStylename("mysort.MySortTextStyle1");
         _para2.x = 247;
         addChild(_bg);
         addChild(_bg2);
         addChild(_mySortImg);
         addChild(_consortiaSortImg);
         addChild(_txtBg1);
         addChild(_txtBg2);
         addChild(_txtBg3);
         addChild(_txtBg4);
         addChild(_sortTxtImg);
         addChild(_levelTxtImg);
         addChild(_expTxtImg);
         addChild(_buildTxtImg);
         addChild(_powtxtImg);
         addChild(_honourImg);
         addChild(_charmsImg);
         addChild(_soulImg);
         addChild(_theseImg);
         addChild(_para1);
         addChild(_para2);
         addChild(_para3);
         addChild(_petNameTxt);
         addChild(_petRankingTxt);
         _mySortImg.visible = false;
         _consortiaSortImg.visible = false;
         _txtBg2.visible = false;
         _levelTxtImg.visible = false;
         _expTxtImg.visible = false;
         _buildTxtImg.visible = false;
         _powtxtImg.visible = false;
         _honourImg.visible = false;
         _charmsImg.visible = false;
         _soulImg.visible = false;
         _theseImg.visible = false;
         _theseImg.x = 307;
         _theseImg.y = 55;
         _txtBg1.x = 66;
         _txtBg2.x = 241;
         _txtBg3.x = 410;
         _para1.x = 81;
         _para2.x = 256;
         _para3.x = 424;
      }
      
      private function uninit() : void
      {
         _bg2 = null;
         _soulImg = null;
         _txtBg4 = null;
         ObjectUtils.disposeAllChildren(this);
         _model = null;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SELECTE_LIST_CHANG",__onSelectedChangeHandler);
         thane.addEventListener("MULTIPLE_AP_UPDATE",__multipleApUpDateHandler);
         playerInfo.addEventListener("MULTIPLE_AP_UPDATE",__multipleApUpDateHandler);
      }
      
      private function remveEvent() : void
      {
         _model.removeEventListener("SELECTE_LIST_CHANG",__onSelectedChangeHandler);
         thane.removeEventListener("MULTIPLE_AP_UPDATE",__multipleApUpDateHandler);
         playerInfo.removeEventListener("MULTIPLE_AP_UPDATE",__multipleApUpDateHandler);
      }
      
      private function __multipleApUpDateHandler(param1:PlayerEvent) : void
      {
         if(_model.currentSelected == 3)
         {
            _para3.text = playerInfo.multipleAp.toString();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
         var _loc2_:SortData = null;
         var _loc8_:SortData = null;
         var _loc9_:Array = null;
         var _loc5_:PetData = null;
         var _loc10_:SortData = null;
         var _loc6_:* = undefined;
         var _loc4_:ChildData = null;
         hideAll();
         switch(int(_model.currentSelected) - 1)
         {
            case 0:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _levelTxtImg.visible = _expTxtImg.visible = true;
               _txtBg1.visible = _txtBg2.visible = _txtBg3.visible = true;
               _para1.visible = _para2.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getGpOrder();
               _para2.text = thane.grades.toString();
               _para3.text = playerInfo.totalGP.toString();
               break;
            case 1:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _powtxtImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getFightCapacityOrder();
               _para3.text = playerInfo.fightingCapacity.toString();
               break;
            case 2:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _powtxtImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getMultipleApOrder();
               _para3.text = playerInfo.multipleAp.toString();
               break;
            case 3:
               _consortiaSortImg.visible = true;
               _sortTxtImg.visible = _powtxtImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               if(playerInfo.consortiaID == 0)
               {
                  _para1.text = "0";
                  _para3.text = "0";
               }
               else
               {
                  _para1.text = consortiaInfo.orderInfo ? consortiaInfo.orderInfo.fightPowerOrder.toString() : "0";
                  _para3.text = consortiaInfo.fightPower.toString();
               }
               break;
            case 4:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _honourImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getHonourOrder();
               _para2.text = "";
               _para3.text = thane.honer.toString();
               break;
            case 5:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _charmsImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getCharmsOrder();
               _para3.text = thane.charms.toString();
               break;
            case 6:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _soulImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _para1.text = playerInfo.playerOrdeInfo.getSoulScoreOrder();
               _para3.text = MountsManager.instance.mountInfo.soulScore.toString();
               break;
            case 8:
               _mySortImg.visible = true;
               _powtxtImg.visible = true;
               _petNameTxt.visible = true;
               _txtBg4.visible = _txtBg3.visible = true;
               _petRankingTxt.visible = _para3.visible = true;
               _loc8_ = _model.isCross ? _model.petRankingCross : _model.petRanking;
               if(_loc8_)
               {
                  _petNameTxt.text = _loc8_.petData.name;
                  _petNameTxt.setFrame(_loc8_.petData.quality);
                  _petRankingTxt.text = _loc8_.orderId + "";
                  _para3.text = _loc8_.petData.fightPower + "";
                  _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
                  _txtBg4.x = 10;
                  _txtBg4.width = _petNameTxt.textWidth + 50 + _petRankingTxt.textWidth;
               }
               else
               {
                  _loc9_ = playerInfo.petList;
                  for each(var _loc3_:PetData in _loc9_)
                  {
                     if(!_loc5_ || _loc3_.fightPower > _loc5_.fightPower)
                     {
                        _loc5_ = _loc3_;
                     }
                  }
                  if(_loc5_)
                  {
                     _petNameTxt.text = _loc5_.name;
                     _petNameTxt.setFrame(_loc5_.quality);
                     _para3.text = "" + _loc5_.fightPower;
                     _petRankingTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
                     _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
                     _txtBg4.x = 10;
                     _txtBg4.width = _petNameTxt.textWidth + 50 + _petRankingTxt.textWidth;
                  }
                  else
                  {
                     _petNameTxt.text = "";
                     _para3.text = "0";
                     _petRankingTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
                     _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
                     _txtBg4.x = 10;
                     _txtBg4.width = _petNameTxt.textWidth + 55 + _petRankingTxt.textWidth;
                  }
               }
               break;
            case 12:
               _mySortImg.visible = true;
               _powtxtImg.visible = true;
               _petNameTxt.visible = true;
               _txtBg4.visible = _txtBg3.visible = true;
               _petRankingTxt.visible = _para3.visible = true;
               _loc10_ = _model.isCross ? _model.childRankingCross : _model.childRanking;
               if(_loc10_)
               {
                  _petNameTxt.text = _loc10_.childData.name;
                  _petNameTxt.setFrame(7);
                  _petRankingTxt.text = _loc10_.orderId + "";
                  _para3.text = _loc10_.childData.fightValue + "";
                  _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
                  _txtBg4.x = 10;
                  _txtBg4.width = _petNameTxt.textWidth + 50 + _petRankingTxt.textWidth;
                  break;
               }
               _loc6_ = childModel.childList;
               for each(var _loc7_:ChildData in _loc6_)
               {
                  if(!_loc4_ || _loc7_.fightValue > _loc4_.fightValue)
                  {
                     _loc4_ = _loc7_;
                  }
               }
               if(_loc4_)
               {
                  _petNameTxt.text = _loc4_.name;
                  _petNameTxt.setFrame(7);
                  _para3.text = "" + _loc4_.fightValue;
                  _petRankingTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
                  _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
                  _txtBg4.x = 10;
                  _txtBg4.width = _petNameTxt.textWidth + 50 + _petRankingTxt.textWidth;
                  break;
               }
               _petNameTxt.text = "";
               _para3.text = "0";
               _petRankingTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
               _petRankingTxt.x = _petNameTxt.x + _petNameTxt.textWidth + 10;
               _txtBg4.x = 10;
               _txtBg4.width = _petNameTxt.textWidth + 55 + _petRankingTxt.textWidth;
               break;
            case 13:
               _mySortImg.visible = true;
               _sortTxtImg.visible = _theseImg.visible = true;
               _txtBg1.visible = _txtBg3.visible = true;
               _para1.visible = _para3.visible = true;
               _loc2_ = _model.isCross ? _model.theseusRankingCross : _model.theseusRanking;
               if(_loc2_ != null)
               {
                  _para1.text = _loc2_.orderId + "";
               }
               else
               {
                  _para1.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
               }
               _para3.text = "" + TheseussoulManager.Instance.model.propertys.armour;
         }
         if(_model.isCross && Boolean(_para1.visible))
         {
            if(_model.currentSelected == 4)
            {
               _para1.text = getPlayerCrossOrder2();
            }
            else
            {
               _para1.text = getPlayerCrossOrder1();
            }
         }
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function getPlayerCrossOrder1() : String
      {
         var _loc5_:int = int(playerInfo.userId);
         var _loc2_:String = playerInfo.nickName;
         var _loc3_:String = playerInfo.serviceName;
         var _loc4_:Array = _model.currentShowList;
         var _loc6_:String = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         for each(var _loc1_:SortData in _loc4_)
         {
            if(_loc1_.serverName == _loc3_ && _loc1_.army.baseHero.userId == _loc5_ && _loc1_.nikcName == _loc2_)
            {
               _loc6_ = _loc1_.orderId.toString();
            }
         }
         return _loc6_;
      }
      
      private function getPlayerCrossOrder2() : String
      {
         var _loc4_:int = int(playerInfo.consortiaID);
         var _loc2_:String = playerInfo.nickName;
         var _loc3_:String = LanguageMgr.GetTranslation("sort.serverName",PlayerManager.instance.currentPlayerModel.userInfo.serverName);
         var _loc5_:Array = _model.currentShowList;
         var _loc6_:String = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         for each(var _loc1_:SortData in _loc5_)
         {
            if(_loc1_.serverName == _loc3_ && _loc1_.army.baseHero.consortiaID == _loc4_)
            {
               _loc6_ = _loc1_.orderId.toString();
            }
         }
         return _loc6_;
      }
      
      private function hideAll() : void
      {
         _buildTxtImg.visible = false;
         _charmsImg.visible = false;
         _consortiaSortImg.visible = false;
         _expTxtImg.visible = false;
         _honourImg.visible = false;
         _levelTxtImg.visible = false;
         _para1.visible = false;
         _para2.visible = false;
         _para3.visible = false;
         _powtxtImg.visible = false;
         _sortTxtImg.visible = false;
         _soulImg.visible = false;
         _txtBg1.visible = false;
         _txtBg2.visible = false;
         _txtBg3.visible = false;
         _mySortImg.visible = false;
         _txtBg4.visible = false;
         _petNameTxt.text = "";
         _petNameTxt.visible = false;
         _petRankingTxt.text = "";
         _petRankingTxt.visible = false;
         _theseImg.visible = false;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      public function dispose() : void
      {
         remveEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

