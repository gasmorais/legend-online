package funny.newyearact
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import managers.NewYearSocketOutManager;
   import newyearact.NewYearActPayModel;
   import newyearact.ProfitInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NewYearActManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class NewYearPayActView extends Sprite
   {
      
      private var _bg:MutipleImage;
      
      private var _diamondItemView:BaseIconView;
      
      private var _bindDiamondItemView:BaseIconView;
      
      private var _diamondNumTxt:FilterFrameText;
      
      private var _bindDiamondTxt:FilterFrameText;
      
      private var _currLevelTxt:GradientText;
      
      private var _proportionSpt:Sprite;
      
      private var _maxBindDiamondTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _actTimeTxt:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _progessBg:Bitmap;
      
      private var _progessBg2:Bitmap;
      
      private var _blueProgess:Bitmap;
      
      private var _blueProgess02:Bitmap;
      
      private var _purpleProgess:Bitmap;
      
      private var _blueProgessMask:Shape;
      
      private var _purpleProgessMask:Shape;
      
      private var _bmd:BitmapData;
      
      private var _helpBtn:BaseButton;
      
      private var _profitTxt1:GradientText;
      
      private var _profitTxt2:GradientText;
      
      private var _profitTxt3:GradientText;
      
      private var _profitTxt4:GradientText;
      
      private var _profitTxt5:GradientText;
      
      private var _profitTxt6:GradientText;
      
      private var _profiltLevel1:GradientText;
      
      private var _profiltLevel2:GradientText;
      
      private var _profiltLevel3:GradientText;
      
      private var _profiltLevel4:GradientText;
      
      private var _profiltLevel5:GradientText;
      
      private var _profiltLevel6:GradientText;
      
      private var _splieLine01:Bitmap;
      
      private var _splieLine02:Bitmap;
      
      private var _splieLine03:Bitmap;
      
      private var _splieLine04:Bitmap;
      
      private var _splieLine05:Bitmap;
      
      private var _numArr:Array;
      
      private var _model:NewYearActPayModel;
      
      private var _manager:NewYearActManager;
      
      private var profitArray:Array;
      
      public function NewYearPayActView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _manager = NewYearActManager.instance;
         _model = _manager.newyearPayModel;
         profitArray = [];
         _bg = ComponentFactory.Instance.creatComponentByStylename("funny.newyearAct.payActBg");
         _diamondItemView = ComponentFactory.Instance.creatCustomObject("funny.newyearact.diamondItem");
         _bindDiamondItemView = ComponentFactory.Instance.creatCustomObject("funny.newyearact.diamondItem");
         _diamondNumTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearAct.itemNumTxt");
         _bindDiamondTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearAct.itemNumTxt");
         _currLevelTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.currProfitLevelDinamicTxt");
         _proportionSpt = new Sprite();
         _maxBindDiamondTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.maxdiamondTxt");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.promptTxt");
         _actTimeTxt = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.actTimeTxt");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getRewardBtn");
         _bmd = ComponentFactory.Instance.creatBitmapData("asset.funny.newyearactNumBmd");
         _progessBg = ComponentFactory.Instance.creatBitmap("asset.funny.newyearact.progess01");
         _progessBg2 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearact.progess02");
         _blueProgess = ComponentFactory.Instance.creatBitmap("asset.funny.blueProgess");
         _blueProgess02 = ComponentFactory.Instance.creatBitmap("asset.funny.blueProgess02");
         _purpleProgess = ComponentFactory.Instance.creatBitmap("asset.funny.purpleprogess");
         _blueProgessMask = new Shape();
         _purpleProgessMask = new Shape();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("funny.newyear.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("funny.newyearPayAct.helpBtnTip");
         _blueProgess.mask = _blueProgessMask;
         _purpleProgess.mask = _purpleProgessMask;
         _numArr = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.numArr").split("|");
         _diamondItemView.tipStyle = "yishi.view.tips.FunnyNewYearItemTip";
         _bindDiamondItemView.tipStyle = "yishi.view.tips.FunnyNewYearItemTip";
         _profitTxt1 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profitTxt2 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profitTxt3 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profitTxt4 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profitTxt5 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profitTxt6 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitDinamicTxt");
         _profiltLevel1 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _profiltLevel2 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _profiltLevel3 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _profiltLevel4 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _profiltLevel5 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _profiltLevel6 = ComponentFactory.Instance.creatComponentByStylename("funny.newyearact.getProfitLevelDinamicTxt");
         _splieLine01 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearLine");
         _splieLine02 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearLine");
         _splieLine03 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearLine");
         _splieLine04 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearLine");
         _splieLine05 = ComponentFactory.Instance.creatBitmap("asset.funny.newyearLine");
         addChild(_bg);
         addChild(_diamondItemView);
         _diamondItemView.x = 104;
         addChild(_bindDiamondItemView);
         _bindDiamondItemView.x = 387;
         addChild(_diamondNumTxt);
         _diamondNumTxt.x = 110;
         addChild(_bindDiamondTxt);
         _bindDiamondTxt.x = 393;
         addChild(_proportionSpt);
         _proportionSpt.y = 179;
         addChild(_currLevelTxt);
         addChild(_maxBindDiamondTxt);
         addChild(_promptTxt);
         _promptTxt.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.promptTxt");
         addChild(_actTimeTxt);
         addChild(_getBtn);
         addChild(_progessBg);
         addChild(_blueProgess);
         addChild(_purpleProgess);
         addChild(_progessBg2);
         addChild(_blueProgessMask);
         addChild(_purpleProgessMask);
         addChild(_splieLine01);
         _splieLine01.x = _blueProgess.x + 53.5 - 3;
         addChild(_splieLine02);
         _splieLine02.x = _blueProgess.x + 107 - 3;
         addChild(_splieLine03);
         _splieLine03.x = _blueProgess.x + 160.5 - 3;
         addChild(_splieLine04);
         _splieLine04.x = _blueProgess.x + 214 - 3;
         addChild(_splieLine05);
         _splieLine05.x = _blueProgess.x + 267.5 - 3;
         _blueProgessMask.x = _purpleProgessMask.x = _blueProgess.x;
         _blueProgessMask.y = _purpleProgessMask.y = _blueProgess.y;
         addChild(_profitTxt1);
         _profitTxt1.x = 15;
         addChild(_profitTxt2);
         _profitTxt2.x = 130;
         addChild(_profitTxt3);
         _profitTxt3.x = 184;
         addChild(_profitTxt4);
         _profitTxt4.x = 237;
         addChild(_profitTxt5);
         _profitTxt5.x = 290;
         addChild(_profitTxt6);
         _profitTxt6.x = 344;
         addChild(_profiltLevel1);
         _profiltLevel1.x = 63;
         addChild(_profiltLevel2);
         _profiltLevel2.x = 121;
         addChild(_profiltLevel3);
         _profiltLevel3.x = 175;
         addChild(_profiltLevel4);
         _profiltLevel4.x = 225;
         addChild(_profiltLevel5);
         _profiltLevel5.x = 280;
         addChild(_profiltLevel6);
         _profiltLevel6.x = 335;
         addChild(_helpBtn);
      }
      
      private function initEvent() : void
      {
         NewYearActManager.instance.addEventListener("REFRESH_PAYACT",refreshData);
         _getBtn.addEventListener("click",__getBtnHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.funny.newyearPayHelpFrame");
         _loc2_["show"]();
      }
      
      public function refreshData(param1:NotificationEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc11_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:ProfitInfo = null;
         var _loc12_:FunnyData = FunnyManager.instance.model.findDataByType(49);
         var _loc3_:String = "";
         var _loc5_:String = DateFormatter.transDate(_loc12_.startTime / 1000);
         var _loc10_:String = DateFormatter.transDate(_loc12_.endTime / 1000);
         _actTimeTxt.htmlText = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.actTimeTxt",_loc5_,_loc10_);
         profitArray = [];
         if(_loc12_ && _loc12_.appendParam != "")
         {
            _loc3_ = _loc12_.appendParam;
            _loc2_ = _loc3_.split("$");
            _loc9_ = 0;
            while(_loc9_ < _loc2_.length)
            {
               _loc7_ = new ProfitInfo();
               _loc11_ = String(_loc2_[_loc9_]).split("@");
               if(_loc11_.length != 4)
               {
                  return;
               }
               _loc7_.minIndex = _loc11_[0];
               _loc7_.maxIndex = _loc11_[1];
               _loc7_.discount = _loc11_[2];
               _loc7_.maxDiamond = _loc11_[3];
               profitArray.push(_loc7_);
               _loc9_++;
            }
            var _loc6_:GoodsInfo = new GoodsInfo();
            _loc6_.templateId = -400;
            _loc6_.count = _model.cur_PayPoint;
            var _loc4_:GoodsInfo = new GoodsInfo();
            _loc4_.templateId = -500;
            if(Math.ceil(_model.cur_PayPoint * getProfitByLevel(_model.curLevel).discount / 100) > getProfitByLevel(_model.curLevel).maxDiamond)
            {
               _loc4_.count = getProfitByLevel(_model.curLevel).maxDiamond;
            }
            else
            {
               _loc4_.count = Math.ceil(_model.cur_PayPoint * getProfitByLevel(_model.curLevel).discount / 100);
            }
            _diamondItemView.icon = IconFactory.getGoodsIconByTID(-400);
            _bindDiamondItemView.icon = IconFactory.getGoodsIconByTID(-500);
            if(_model.curLevel > 0)
            {
               _currLevelTxt.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.currLevel",_numArr[_model.curLevel - 1],getProfitByLevel(_model.curLevel).discount);
            }
            else
            {
               _currLevelTxt.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.currLevel_2");
            }
            _maxBindDiamondTxt.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.maxBindDiamondTxt",getProfitByLevel(_model.curLevel).maxDiamond);
            _profitTxt1.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profitTxt",getProfitByLevel(1).discount);
            _profitTxt2.text = getProfitByLevel(2).discount + "%";
            _profitTxt3.text = getProfitByLevel(3).discount + "%";
            _profitTxt4.text = getProfitByLevel(4).discount + "%";
            _profitTxt5.text = getProfitByLevel(5).discount + "%";
            _profitTxt6.text = getProfitByLevel(6).discount + "%";
            _profiltLevel1.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[0]);
            _profiltLevel2.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[1]);
            _profiltLevel3.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[2]);
            _profiltLevel4.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[3]);
            _profiltLevel5.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[4]);
            _profiltLevel6.text = LanguageMgr.GetTranslation("funny.newyearact.NewYearPayActView.profiltLevel",_numArr[5]);
            var _loc8_:Object = {};
            _loc8_["index"] = _model.curLevel;
            _loc8_["profit"] = getProfitByLevel(_model.curLevel).discount;
            _loc8_["maxDiamond"] = getProfitByLevel(_model.curLevel).maxDiamond;
            _diamondItemView.tipData = _loc8_;
            _bindDiamondItemView.tipData = _loc8_;
            _diamondNumTxt.text = getNumStr(_model.cur_PayPoint);
            _bindDiamondTxt.text = getNumStr(_loc4_.count);
            NumberViewUtils.refreshTimeValue(getProfitByLevel(_model.curLevel).discount + "%",_proportionSpt,_bmd,18,16,13,15,"0123456789%");
            _proportionSpt.x = 209 + (132 - _proportionSpt.width) / 2;
            setProgress(_blueProgessMask,_model.payCount,true,getProfitByLevel(_model.payCount + 1).maxDiamond,Math.ceil(_model.cur_PayPoint * getProfitByLevel(_model.payCount + 1).discount / 100));
            setProgress(_purpleProgessMask,_model.getCount);
            if(_model.payCount > _model.getCount)
            {
               _getBtn.enable = true;
            }
            else
            {
               _getBtn.enable = false;
            }
            if(_model.payCount >= 6)
            {
               _diamondItemView.filters = [UIFilter.getBlackFilter()];
               _bindDiamondItemView.filters = [UIFilter.getBlackFilter()];
               _diamondNumTxt.filters = [UIFilter.getBlackFilter()];
               _bindDiamondTxt.filters = [UIFilter.getBlackFilter()];
               _currLevelTxt.filters = [UIFilter.getBlackFilter()];
               _proportionSpt.filters = [UIFilter.getBlackFilter()];
               _maxBindDiamondTxt.filters = [UIFilter.getBlackFilter()];
               _promptTxt.filters = [UIFilter.getBlackFilter()];
               _bindDiamondItemView.tipData = null;
               _diamondItemView.tipData = null;
            }
            else
            {
               _diamondItemView.filters = null;
               _bindDiamondItemView.filters = null;
               _proportionSpt.filters = null;
               _diamondNumTxt.filterString = "core.normal_f";
               _bindDiamondTxt.filterString = "core.normal_f";
               _currLevelTxt.filterString = "core.normal_f";
               _maxBindDiamondTxt.filterString = "core.normal_f";
               _promptTxt.filterString = "core.normal_f";
            }
            return;
         }
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         NewYearSocketOutManager.sendGetProfilt(1);
      }
      
      private function getNumStr(param1:Number) : String
      {
         var _loc2_:String = null;
         var _loc3_:Number = param1 / 10000;
         if(param1 % 10000 == 0)
         {
            if(_loc3_ >= 1)
            {
               _loc2_ = int(_loc3_) + "0K";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = _loc3_.toFixed(1) + "0K";
         }
         else if(_loc3_ > 10)
         {
            _loc2_ = int(_loc3_) + "0K";
         }
         return param1.toString();
      }
      
      public function getProfitByLevel(param1:int) : ProfitInfo
      {
         var _loc2_:int = 0;
         if(param1 == 0)
         {
            param1 = 1;
         }
         if(param1 > 6)
         {
            param1 = 6;
         }
         _loc2_ = 0;
         while(_loc2_ < profitArray.length)
         {
            if(param1 >= (profitArray[_loc2_] as ProfitInfo).minIndex && param1 <= (profitArray[_loc2_] as ProfitInfo).maxIndex)
            {
               return profitArray[_loc2_] as ProfitInfo;
            }
            _loc2_++;
         }
         throw new Error("第" + param1 + "档没有配参数");
      }
      
      private function setProgress(param1:Shape, param2:int, param3:Boolean = false, param4:int = 0, param5:int = 0) : void
      {
         var _loc6_:int = 0;
         param1.graphics.clear();
         param1.graphics.lineStyle(1,0,0);
         param1.graphics.beginFill(16777215,0);
         if(!param3)
         {
            param1.graphics.drawRect(0,0,int(321 * (param2 / 6)),11);
         }
         else
         {
            _loc6_ = 321;
            if(param2 != 6)
            {
               if(param5 > param4)
               {
                  param5 = param4;
               }
               _loc6_ = 321 * param2 / 6 + 53.5 * param5 / param4;
            }
            param1.graphics.drawRect(0,0,_loc6_,11);
         }
         param1.graphics.endFill();
      }
      
      private function removeEvent() : void
      {
         NewYearActManager.instance.removeEventListener("REFRESH_PAYACT",refreshData);
         _getBtn.removeEventListener("click",__getBtnHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_diamondItemView)
         {
            ObjectUtils.disposeObject(_diamondItemView);
         }
         _diamondItemView = null;
         if(_bindDiamondItemView)
         {
            ObjectUtils.disposeObject(_bindDiamondItemView);
         }
         _bindDiamondItemView = null;
         if(_diamondNumTxt)
         {
            ObjectUtils.disposeObject(_diamondNumTxt);
         }
         _diamondNumTxt = null;
         if(_bindDiamondTxt)
         {
            ObjectUtils.disposeObject(_bindDiamondTxt);
         }
         _bindDiamondTxt = null;
         if(_currLevelTxt)
         {
            ObjectUtils.disposeObject(_currLevelTxt);
         }
         _currLevelTxt = null;
         if(_proportionSpt)
         {
            ObjectUtils.disposeObject(_proportionSpt);
         }
         _proportionSpt = null;
         if(_maxBindDiamondTxt)
         {
            ObjectUtils.disposeObject(_maxBindDiamondTxt);
         }
         _maxBindDiamondTxt = null;
         if(_promptTxt)
         {
            ObjectUtils.disposeObject(_promptTxt);
         }
         _promptTxt = null;
         if(_actTimeTxt)
         {
            ObjectUtils.disposeObject(_actTimeTxt);
         }
         _actTimeTxt = null;
         if(_getBtn)
         {
            ObjectUtils.disposeObject(_getBtn);
         }
         _getBtn = null;
         if(_progessBg)
         {
            ObjectUtils.disposeObject(_progessBg);
         }
         _progessBg = null;
         if(_progessBg2)
         {
            ObjectUtils.disposeObject(_progessBg2);
         }
         _progessBg2 = null;
         if(_blueProgess)
         {
            ObjectUtils.disposeObject(_blueProgess);
         }
         _blueProgess = null;
         if(_blueProgess02)
         {
            ObjectUtils.disposeObject(_blueProgess02);
         }
         _blueProgess02 = null;
         if(_purpleProgess)
         {
            ObjectUtils.disposeObject(_purpleProgess);
         }
         _purpleProgess = null;
         if(_blueProgessMask)
         {
            ObjectUtils.disposeObject(_blueProgessMask);
         }
         _blueProgessMask = null;
         if(_purpleProgessMask)
         {
            ObjectUtils.disposeObject(_purpleProgessMask);
         }
         _purpleProgessMask = null;
         if(_bmd)
         {
            ObjectUtils.disposeObject(_bmd);
         }
         _bmd = null;
         if(_profitTxt1)
         {
            ObjectUtils.disposeObject(_profitTxt1);
         }
         _profitTxt1 = null;
         if(_profitTxt2)
         {
            ObjectUtils.disposeObject(_profitTxt2);
         }
         _profitTxt2 = null;
         if(_profitTxt3)
         {
            ObjectUtils.disposeObject(_profitTxt3);
         }
         _profitTxt3 = null;
         if(_profitTxt4)
         {
            ObjectUtils.disposeObject(_profitTxt4);
         }
         _profitTxt4 = null;
         if(_profitTxt5)
         {
            ObjectUtils.disposeObject(_profitTxt5);
         }
         _profitTxt5 = null;
         if(_profitTxt6)
         {
            ObjectUtils.disposeObject(_profitTxt6);
         }
         _profitTxt6 = null;
         if(_profiltLevel1)
         {
            ObjectUtils.disposeObject(_profiltLevel1);
         }
         _profiltLevel1 = null;
         if(_profiltLevel2)
         {
            ObjectUtils.disposeObject(_profiltLevel2);
         }
         _profiltLevel2 = null;
         if(_profiltLevel3)
         {
            ObjectUtils.disposeObject(_profiltLevel3);
         }
         _profiltLevel3 = null;
         if(_profiltLevel4)
         {
            ObjectUtils.disposeObject(_profiltLevel4);
         }
         _profiltLevel4 = null;
         if(_profiltLevel5)
         {
            ObjectUtils.disposeObject(_profiltLevel5);
         }
         _profiltLevel5 = null;
         if(_profiltLevel6)
         {
            ObjectUtils.disposeObject(_profiltLevel6);
         }
         _profiltLevel6 = null;
         if(_splieLine01)
         {
            ObjectUtils.disposeObject(_splieLine01);
         }
         _splieLine01 = null;
         if(_splieLine02)
         {
            ObjectUtils.disposeObject(_splieLine02);
         }
         _splieLine02 = null;
         if(_splieLine03)
         {
            ObjectUtils.disposeObject(_splieLine03);
         }
         _splieLine03 = null;
         if(_splieLine04)
         {
            ObjectUtils.disposeObject(_splieLine04);
         }
         _splieLine04 = null;
         if(_splieLine05)
         {
            ObjectUtils.disposeObject(_splieLine05);
         }
         _splieLine05 = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
      }
   }
}

